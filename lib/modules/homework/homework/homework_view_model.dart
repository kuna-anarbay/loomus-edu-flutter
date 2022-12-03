import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loomus_app/base/base_view_model.dart';
import 'package:loomus_app/data/repository/homework_repository.dart';
import 'package:loomus_app/models/homework/homework.dart';
import 'package:loomus_app/models/homework/homework_submission.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/homework/homework_resource_widget.dart';
import 'package:loomus_app/widgets/homework/student_work_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../components/alert/bottom_sheet_action.dart';
import '../../../components/alert/bottom_sheet_alert.dart';
import '../../../components/alert/cancel_action.dart';
import '../../../models/homework/homework_resource.dart';
import '../../../utilities/ls_color.dart';

class HomeworkDataSource {
  final Homework homework;
  final bool isHomeworkAvailable;

  HomeworkDataSource(this.homework, this.isHomeworkAvailable);
}

mixin HomeworkDelegate {
  void editHomeworkSubmission(HomeworkSubmission submission);
}

class HomeworkViewModel extends BaseViewModel
    with HomeworkResourceWidgetDelegate, StudentWorkWidgetDelegate {
  final HomeworkRepository homeworkRepository;
  final Homework homework;
  final HomeworkDelegate delegate;
  final bool isHomeworkAvailable;
  bool isResourceLoading = false;
  HomeworkSubmission? submission;
  bool isSubmitting = false;
  File? file;
  String value = "";

  HomeworkViewModel(
      HomeworkDataSource dataSource, this.delegate, this.homeworkRepository)
      : homework = dataSource.homework,
        submission = dataSource.homework.submission,
        isHomeworkAvailable = dataSource.isHomeworkAvailable {
    AnalyticsService.openedPageHomework(homework.courseId, homework.id);
  }

  @override
  pickFile(BuildContext context, AppLocalizations? local) async {
    AnalyticsService.pressAttachHomeworkSubmissionImage(
        homework.courseId, homework.id);
    List<BottomSheetAction> actions = [
      BottomSheetAction(
          title: Text(local?.homeworkPageGallery ?? "",
              style: const TextStyle(
                  color: LsColor.brand, fontWeight: FontWeight.normal)),
          onPressed: (context) {
            AnalyticsService.pressSelectHomeworkSubmissionImage(
                homework.courseId, homework.id, "gallery");
            pickImage(ImageSource.gallery, context);
          }),
      BottomSheetAction(
          title: Text(local?.homeworkPageCamera ?? "",
              style: const TextStyle(
                  color: LsColor.brand, fontWeight: FontWeight.normal)),
          onPressed: (context) {
            AnalyticsService.pressSelectHomeworkSubmissionImage(
                homework.courseId, homework.id, "camera");
            pickImage(ImageSource.camera, context);
          })
    ];
    showAdaptiveActionSheet(
        context: context,
        actions: actions,
        cancelAction: CancelAction(
            title: Text(local?.homeworkPageCancel ?? "",
                style: const TextStyle(
                    color: LsColor.brand, fontWeight: FontWeight.w600))));
  }

  pickImage(ImageSource source, BuildContext context) async {
    LsRouter(context).pop();
    final ImagePicker imagePicker = ImagePicker();
    final value = await imagePicker.pickImage(
        source: source, maxHeight: 1280, maxWidth: 1280);
    if (value == null) return;
    file = File(value.path);
    notifyListeners();
  }

  Future<void> submitHomework() async {
    if (isSubmitting) return;
    AnalyticsService.pressSubmitHomework(homework.courseId, homework.id);
    isSubmitting = true;
    notifyListeners();
    try {
      final result = await homeworkRepository.submitHomework(
          homework.courseId, homework.id, value, file);
      submission = result;
      delegate.editHomeworkSubmission(result);
      isSubmitting = false;
      notifyListeners();
    } catch (e) {
      toastDioError(e);
      isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void downloadHomeworkResource(HomeworkResource resource) async {
    try {
      AnalyticsService.pressDownloadHomeworkResource(
          homework.courseId, homework.id, "homework");
      isResourceLoading = true;
      notifyListeners();
      final url = await homeworkRepository.getHomeworkResourceDownloadUrl(
          resource.courseId, resource.homeworkId);
      if (await canLaunchUrl(Uri.parse(url))) {
        isResourceLoading = false;
        notifyListeners();
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      isResourceLoading = false;
      notifyListeners();
      toastDioError(e);
    }
  }

  @override
  void removeFile() {
    AnalyticsService.pressRemoveHomeworkSubmissionImage(
        homework.courseId, homework.id);
    file = null;
    notifyListeners();
  }

  @override
  void onChanged(String value) {
    this.value = value;
  }

  @override
  void textManager() {
    String url =
        "https://wa.me/+77066308907?text=%D2%9A%D0%B0%D0%B9%D1%8B%D1%80%D0%BB%D1%8B+%D0%BA%D2%AF%D0%BD%21+Pro+%D1%82%D0%B0%D1%80%D0%B8%D1%84%D1%8B+%D0%B6%D0%B0%D0%B9%D0%BB%D1%8B+%D1%82%D0%BE%D0%BB%D1%8B%D2%93%D1%8B%D1%80%D0%B0%D2%9B+%D0%B1%D1%96%D0%BB%D0%B3%D1%96%D0%BC+%D0%BA%D0%B5%D0%BB%D0%B5%D0%B4%D1%96.";
    launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
