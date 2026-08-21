import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CalculatorButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.flex = 1,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.surfaceLight;
    
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.buttonPadding),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: Transform.scale(
            scale: _isPressed ? 0.95 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withValues(alpha: _isPressed ? 0.2 : 0.4),
                    blurRadius: _isPressed ? 8.0 : 12.0,
                    spreadRadius: _isPressed ? 0.0 : 1.0,
                    offset: Offset(0, _isPressed ? 2.0 : 4.0),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius),
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: AppDimensions.buttonFontSize,
                        fontWeight: FontWeight.w600,
                        color: widget.foregroundColor ?? AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
