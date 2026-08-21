import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CalculatorDisplay extends StatelessWidget {
  final String display;
  final String previousValue;
  final String operation;

  const CalculatorDisplay({
    super.key,
    required this.display,
    required this.previousValue,
    required this.operation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.containerPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.containerPadding,
        vertical: 32.0,
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
          if (previousValue.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '$previousValue $operation',
                style: const TextStyle(
                  fontSize: AppDimensions.operationFontSize,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          Text(
            display,
            style: const TextStyle(
              fontSize: AppDimensions.displayFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -1.0,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
