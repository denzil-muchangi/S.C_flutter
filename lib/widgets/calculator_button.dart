import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

/// A custom button widget for the calculator.
/// 
/// It features a 'glassmorphic' style with gradients, shadows, and 
/// interactive animations when pressed.
class CalculatorButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final int flex;
  final double? height;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.flex = 1,
    this.height,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  // Local state to track if the button is currently being held down.
  // This is used for the scaling animation and shadow depth changes.
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.surfaceLight;
    
    // We adjust button sizes based on orientation and screen width.
    final isLandscape =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final isTablet = MediaQuery.of(context).size.width > 900;

    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: EdgeInsets.all(isLandscape && !isTablet
            ? AppDimensions.buttonPadding / 2
            : AppDimensions.buttonPadding),
        child: GestureDetector(
          // Detect when the user touches the button.
          onTapDown: (_) => setState(() => _isPressed = true),
          
          // Detect when the user lifts their finger.
          onTapUp: (_) => setState(() => _isPressed = false),
          
          // Detect if the touch is canceled (e.g., swiping away).
          onTapCancel: () => setState(() => _isPressed = false),
          
          child: Transform.scale(
            // [Transform.scale] creates a subtle "squish" effect when pressed.
            scale: _isPressed ? 0.95 : 1.0,
            child: Container(
              height: widget.height ?? (isLandscape && !isTablet ? 55.0 : 80.0),
              decoration: BoxDecoration(
                // A gradient gives the button a 3D, modern look.
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    bgColor,
                    bgColor.withValues(alpha: 0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                boxShadow: [
                  // Multiple shadows create depth.
                  // We decrease the blur and offset when pressed to simulate the button moving down.
                  BoxShadow(
                    color:
                        Colors.black.withValues(alpha: _isPressed ? 0.1 : 0.3),
                    blurRadius: _isPressed ? 4.0 : 8.0,
                    offset: Offset(0, _isPressed ? 1.0 : 3.0),
                  ),
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
                  onTap: () {
                    // [HapticFeedback.lightImpact] provides a subtle physical vibration.
                    HapticFeedback.lightImpact();
                    widget.onPressed();
                  },
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius),
                  // Splash color appears when the button is tapped.
                  splashColor: Colors.white.withValues(alpha: 0.1),
                  highlightColor: Colors.transparent,
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: isLandscape && !isTablet
                            ? AppDimensions.buttonFontSize * 0.7
                            : AppDimensions.buttonFontSize,
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
