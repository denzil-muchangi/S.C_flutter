/// [CalculatorState] handles the business logic for the calculator.
/// 
/// It maintains the current state of the calculation, including the current display,
/// previous value, current operation, and history.
class CalculatorState {
  /// The value currently shown on the main display area.
  String display = '0';
  
  /// The first operand in a two-number operation (e.g., '5' in '5 + 3').
  String previousValue = '';
  
  /// The current mathematical operator chosen (+, -, ×, ÷).
  String operation = '';
  
  /// Stores the full expression string for display (e.g., '5 + 3 =').
  String lastExpression = '';
  
  /// A list of recent calculation results for history tracking.
  List<String> history = [];
  
  /// Flag to indicate if the display should be cleared when the next number is pressed.
  /// This happens after an operation is selected or equals is pressed.
  bool shouldResetDisplay = false;

  /// Handles when a number button (0-9) is tapped.
  void handleNumberPress(String number) {
    if (shouldResetDisplay) {
      // If we just finished a calculation or selected an operator, 
      // start fresh with the new number.
      if (lastExpression.isNotEmpty) {
        lastExpression = '';
      }
      display = number;
      shouldResetDisplay = false;
    } else {
      // Append the number to the current display, but handle the initial '0' case.
      display = display == '0' ? number : display + number;
    }
  }

  /// Handles when an operation button (+, -, ×, ÷) is tapped.
  void handleOperation(String op) {
    lastExpression = '';
    
    if (previousValue.isEmpty) {
      // First operand is the current display.
      previousValue = display;
    } else if (!shouldResetDisplay) {
      // Chain calculations (e.g., 5 + 3 + ... calculates 8 first).
      calculate();
      previousValue = display;
    }
    
    operation = op;
    shouldResetDisplay = true;
  }

  /// Performs the actual mathematical calculation based on the stored state.
  void calculate() {
    if (previousValue.isEmpty || operation.isEmpty) return;

    double prev = double.tryParse(previousValue) ?? 0;
    double current = double.tryParse(display) ?? 0;
    double result = 0;

    // Execute logic based on the operator.
    switch (operation) {
      case '+':
        result = prev + current;
        break;
      case '-':
        result = prev - current;
        break;
      case '×':
        result = prev * current;
        break;
      case '÷':
        // Basic division by zero protection.
        result = current != 0 ? prev / current : 0;
        break;
      default:
        return;
    }

    // Prepare the expression for history and display controllers.
    lastExpression = '$previousValue $operation $display =';
    
    // Format the result: remove trailing .0 for integers.
    display = result % 1 == 0 ? result.toInt().toString() : result.toString();
    
    // Add to history and keep it within limits.
    history.insert(0, '$lastExpression $display');
    if (history.length > 20) history.removeLast();
    
    // Reset operands for the next operation.
    previousValue = '';
    operation = '';
    shouldResetDisplay = true;
  }

  /// Returns a preview of the calculation result while typing.
  /// Used to show what the result would be if '=' was pressed now.
  String getPreviewResult() {
    if (previousValue.isEmpty || operation.isEmpty || shouldResetDisplay) {
      return '';
    }
    
    double prev = double.tryParse(previousValue) ?? 0;
    double current = double.tryParse(display) ?? 0;
    double result = 0;

    switch (operation) {
      case '+': result = prev + current; break;
      case '-': result = prev - current; break;
      case '×': result = prev * current; break;
      case '÷': result = current != 0 ? prev / current : 0; break;
      default: return '';
    }
    
    return result % 1 == 0 ? result.toInt().toString() : result.toString();
  }

  /// Wrapper for [calculate] called by the equals button.
  void handleEquals() {
    calculate();
  }

  /// Resets the calculator to its initial state.
  void handleClear() {
    display = '0';
    previousValue = '';
    operation = '';
    lastExpression = '';
    shouldResetDisplay = false;
  }

  /// Appends a decimal point if one doesn't already exist in the display.
  void handleDecimal() {
    if (shouldResetDisplay) {
      lastExpression = '';
      display = '0.';
      shouldResetDisplay = false;
      return;
    }
    if (!display.contains('.')) {
      display = '$display.';
    }
  }
}
