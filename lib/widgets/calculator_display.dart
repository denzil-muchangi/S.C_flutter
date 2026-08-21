import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// The display area of the calculator where numbers and operations are shown.
/// 
/// It uses a glassmorphic design style with semi-transparent gradients, 
/// subtle borders, and layered shadows to create a modern UI.
class CalculatorDisplay extends StatelessWidget {
  // Controllers passed from the screen to manage the text dynamically.
  final TextEditingController inputController;
  final TextEditingController resultController;

  const CalculatorDisplay({
    super.key,
    required this.inputController,
    required this.resultController,
  });

  @override
  Widget build(BuildContext context) {
    // Check orientation for responsive adjustments.
    final isLandscape =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final isTablet = MediaQuery.of(context).size.width > 900;

    return Container(
      margin: EdgeInsets.all(
          isLandscape && !isTablet ? 10.0 : AppDimensions.containerPadding),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.containerPadding,
        vertical: isLandscape && !isTablet ? 12.0 : 24.0,
      ),
      decoration: BoxDecoration(
        // The display has a deep blue gradient for high contrast with white text.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.displayBackground,
            AppColors.displayBackground.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.displayBorderRadius),
        // A thin semi-transparent border is key for the glassmorphic look.
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          // A deep black shadow for grounding.
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          // A subtle primary-colored glow.
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: AppDimensions.shadowBlur,
            spreadRadius: AppDimensions.shadowSpread,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // [TextField] is used for display here because it handles text alignment, 
          // cursors (which we hide), and selection better than simple [Text] widgets 
          // in some scenarios. We set [readOnly: true] so the user can't type via keyboard.
          TextField(
            controller: inputController,
            readOnly: true,
            showCursor: false,
            enableInteractiveSelection: false,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isLandscape && !isTablet
                  ? AppDimensions.operationFontSize * 0.8
                  : AppDimensions.operationFontSize,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  EdgeInsets.only(bottom: isLandscape && !isTablet ? 4.0 : 8.0),
            ),
          ),
          // Main result TextField.
          TextField(
            controller: resultController,
            readOnly: true,
            showCursor: false,
            enableInteractiveSelection: false,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isLandscape && !isTablet
                  ? AppDimensions.displayFontSize * 0.6
                  : AppDimensions.displayFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -1.0,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
