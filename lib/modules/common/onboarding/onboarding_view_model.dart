import 'package:flutter/cupertino.dart';
import 'package:loomus_app/base/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel();

  PageController pageController = PageController();

  int currentPage = 0;

  onPageChanged(int value) {
    currentPage = value;
    notifyListeners();
  }

  onChangePage() {
    currentPage += 1;
    pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
