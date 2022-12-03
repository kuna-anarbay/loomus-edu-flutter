import 'package:flutter/material.dart';
import 'package:loomus_app/utilities/ls_color.dart';

class PageControl extends AnimatedWidget {
  const PageControl(
      {super.key,
      required this.controller,
      required this.itemCount,
      this.color = LsColor.brand,
      this.selectedColor = LsColor.brand})
      : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  final Color selectedColor;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 18.0;

  Widget _buildDot(int index) {
    final isCurrentPage =
        (index - (controller.page ?? controller.initialPage)).abs() <= 0.5;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: isCurrentPage ? selectedColor : color.withOpacity(0.25),
          type: MaterialType.circle,
          child: const SizedBox(width: _kDotSize, height: _kDotSize),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
