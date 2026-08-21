import 'package:flutter/material.dart';
import '../models/calculator_state.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';
import '../constants/app_constants.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorState _calculator = CalculatorState();

  void _setState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            CalculatorDisplay(
              display: _calculator.display,
              previousValue: _calculator.previousValue,
              operation: _calculator.operation,
            ),
            // Button Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(
                  AppDimensions.containerPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row 1: C, ÷, ×
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(
                              AppDimensions.buttonPadding,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.error.withValues(alpha: 0.3),
                                    blurRadius: 12.0,
                                    spreadRadius: 1.0,
                                    offset: const Offset(0, 4.0),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _calculator.handleClear();
                                    _setState();
                                  },
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppStrings.clearButton,
                                      style: TextStyle(
                                        fontSize:
                                            AppDimensions.buttonFontSize,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CalculatorButton(
                          label: AppStrings.divideSymbol,
                          onPressed: () {
                            _calculator.handleOperation(
                              AppStrings.divideSymbol,
                            );
                            _setState();
                          },
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black87,
                        ),
                        CalculatorButton(
                          label: AppStrings.multiplySymbol,
                          onPressed: () {
                            _calculator.handleOperation(
                              AppStrings.multiplySymbol,
                            );
                            _setState();
                          },
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black87,
                        ),
                      ],
                    ),
                    // Row 2: 7, 8, 9, -
                    Row(
                      children: [
                        CalculatorButton(
                          label: '7',
                          onPressed: () {
                            _calculator.handleNumberPress('7');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '8',
                          onPressed: () {
                            _calculator.handleNumberPress('8');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '9',
                          onPressed: () {
                            _calculator.handleNumberPress('9');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: AppStrings.subtractSymbol,
                          onPressed: () {
                            _calculator.handleOperation(
                              AppStrings.subtractSymbol,
                            );
                            _setState();
                          },
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black87,
                        ),
                      ],
                    ),
                    // Row 3: 4, 5, 6, +
                    Row(
                      children: [
                        CalculatorButton(
                          label: '4',
                          onPressed: () {
                            _calculator.handleNumberPress('4');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '5',
                          onPressed: () {
                            _calculator.handleNumberPress('5');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '6',
                          onPressed: () {
                            _calculator.handleNumberPress('6');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: AppStrings.addSymbol,
                          onPressed: () {
                            _calculator.handleOperation(
                              AppStrings.addSymbol,
                            );
                            _setState();
                          },
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black87,
                        ),
                      ],
                    ),
                    // Row 4: 1, 2, 3, =
                    Row(
                      children: [
                        CalculatorButton(
                          label: '1',
                          onPressed: () {
                            _calculator.handleNumberPress('1');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '2',
                          onPressed: () {
                            _calculator.handleNumberPress('2');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: '3',
                          onPressed: () {
                            _calculator.handleNumberPress('3');
                            _setState();
                          },
                        ),
                        CalculatorButton(
                          label: AppStrings.equalsButton,
                          onPressed: () {
                            _calculator.handleEquals();
                            _setState();
                          },
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.black87,
                        ),
                      ],
                    ),
                    // Row 5: 0, .
                    Row(
                      children: [
                        CalculatorButton(
                          label: '0',
                          onPressed: () {
                            _calculator.handleNumberPress('0');
                            _setState();
                          },
                          flex: 2,
                        ),
                        CalculatorButton(
                          label: AppStrings.decimalPoint,
                          onPressed: () {
                            _calculator.handleDecimal();
                            _setState();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
