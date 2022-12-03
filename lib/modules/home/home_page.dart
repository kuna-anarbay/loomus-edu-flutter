import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/modules/profile/profile_view_model.dart';
import 'package:loomus_app/services/analytics_service.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:loomus_app/widgets/common/loading_page_widget.dart';
import 'package:loomus_app/widgets/course/course_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final AppLocalizations? local = AppLocalizations.of(context);

    return PlatformScaffold(
        backgroundColor: LsColor.background,
        appBar: PlatformAppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(local?.homePageTitle ?? "",
                        style: const TextStyle(color: LsColor.label))),
                GestureDetector(
                  onTap: () {
                    AnalyticsService.pressOpenPageProfile();
                    LsRouter(context)
                        .openProfile(ProfileDataSource(viewModel.user));
                  },
                  child: Image.asset("assets/images/gear.png",
                      height: 24, width: 24, color: LsColor.brand),
                )
              ],
            ),
          ),
          material: (_, __) => MaterialAppBarData(
              shadowColor: const Color.fromRGBO(37, 37, 37, 0.1)),
        ),
        body: SafeArea(
            child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: viewModel.isLoading
                      ? const LoadingPageWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: viewModel.courses
                              .map((course) => CourseCard(course, viewModel))
                              .toList()),
                ))));
  }
}
