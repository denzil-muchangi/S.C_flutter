import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CalculatorDisplay extends StatelessWidget {
  final TextEditingController inputController;
  final TextEditingController resultController;

  const CalculatorDisplay({
    super.key,
    required this.inputController,
    required this.resultController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.containerPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.containerPadding,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.displayBackground,
        borderRadius: BorderRadius.circular(AppDimensions.displayBorderRadius),
        border: Border.all(
          color: AppColors.displayBorder.withValues(alpha: 0.3),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: AppDimensions.shadowBlur,
            spreadRadius: AppDimensions.shadowSpread,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: inputController,
            readOnly: true,
            showCursor: false,
            enableInteractiveSelection: false,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: AppDimensions.operationFontSize,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 8.0),
            ),
          ),
          TextField(
            controller: resultController,
            readOnly: true,
            showCursor: false,
            enableInteractiveSelection: false,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: AppDimensions.displayFontSize,
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
