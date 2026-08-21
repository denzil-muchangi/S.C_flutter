import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/calculator_state.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';
import '../constants/app_constants.dart';

/// The main entry screen for the Calculator app.
/// 
/// It coordinates the [CalculatorState] (logic) with the UI widgets.
/// It uses [TextEditingController]s to manage what is shown in the display.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // The business logic instance.
  final CalculatorState _calculator = CalculatorState();
  
  // Controllers are used to programmatically set the text in the display area.
  // This is often more flexible than just using simple String variables for UI state.
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks!
    _inputController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  /// Maps the internal [CalculatorState] to the text controllers.
  /// This logic decides what appears in the top 'expression' line and bottom 'result' line.
  void _updateControllers() {
    if (_calculator.lastExpression.isNotEmpty) {
      // Case: Just finished a calculation (e.g., "5 + 3 =").
      _inputController.text = _calculator.lastExpression;
      _resultController.text = _calculator.display;
    } else if (_calculator.operation.isNotEmpty) {
      // Case: An operation is in progress (e.g., "5 + ").
      _inputController.text = '${_calculator.previousValue} ${_calculator.operation} ${_calculator.shouldResetDisplay ? '' : _calculator.display}';
      
      // Live preview shows the calculated result even before '=' is pressed.
      final preview = _calculator.getPreviewResult();
      _resultController.text = preview.isNotEmpty ? preview : _calculator.display;
    } else {
      // Case: Default/Clear state.
      _inputController.text = '';
      _resultController.text = _calculator.display;
    }
  }

  /// Trigger a UI rebuild and update controllers.
  void _setState() {
    setState(() {
      _updateControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // [MediaQuery] allows us to get information about the device's screen size and orientation.
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    // We define a 'tablet' as having a width greater than 900 pixels.
    final isTablet = mediaQuery.size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      // Hide AppBar in landscape mobile to save vertical space.
      appBar: isLandscape && !isTablet
          ? null
          : AppBar(
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
            ),
      body: SafeArea(
        // [SafeArea] ensures content isn't obscured by system notches or status bars.
        child: LayoutBuilder(
          // [LayoutBuilder] provides constraints from the parent, which helps in making 
          // widgets resize dynamically based on available space.
          builder: (context, constraints) {
            
            // Layout logic for Landscape Mobile (Side-by-side display and buttons).
            if (isLandscape && !isTablet) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: SingleChildScrollView(
                        child: CalculatorDisplay(
                          inputController: _inputController,
                          resultController: _resultController,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: _buildButtonGrid(isLandscape: true),
                      ),
                    ),
                  ),
                ],
              );
            }

            // Layout logic for Portrait Mobile and Tablets.
            final contentWidth = isTablet ? 500.0 : constraints.maxWidth;

            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Show History panel only on tablets for a "Pro" layout.
                  if (isTablet)
                    Container(
                      width: 300,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'History',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _calculator.history.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _calculator.history[index],
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // The main calculator core (Display + Buttons).
                  SizedBox(
                    width: contentWidth,
                    child: Column(
                      children: [
                        CalculatorDisplay(
                          inputController: _inputController,
                          resultController: _resultController,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.containerPadding,
                              vertical: 10.0,
                            ),
                            child: SingleChildScrollView(
                              child: _buildButtonGrid(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the grid of calculator buttons.
  Widget _buildButtonGrid({bool isLandscape = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Row 1: C, ÷, ×
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppDimensions.buttonPadding,
                ),
                child: Container(
                  height: isLandscape ? 55 : 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.error,
                        AppColors.error.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.error.withValues(alpha: 0.3),
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
                        // [HapticFeedback] provides physical vibration response to touch.
                        HapticFeedback.mediumImpact();
                        _calculator.handleClear();
                        _setState();
                      },
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                      splashColor: Colors.white24,
                      child: Center(
                        child: Text(
                          AppStrings.clearButton,
                          style: TextStyle(
                            fontSize: isLandscape
                                ? AppDimensions.buttonFontSize * 0.8
                                : AppDimensions.buttonFontSize,
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
            const Spacer(flex: 1),
          ],
        ),
      ],
    );
  }
}
