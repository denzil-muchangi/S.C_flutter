class CalculatorState {
  String display = '0';
  String previousValue = '';
  String operation = '';
  bool shouldResetDisplay = false;

  void handleNumberPress(String number) {
    if (shouldResetDisplay) {
      display = number;
      shouldResetDisplay = false;
    } else {
      display = display == '0' ? number : display + number;
    }
  }

  void handleOperation(String op) {
    if (previousValue.isEmpty) {
      previousValue = display;
    } else if (!shouldResetDisplay) {
      calculate();
      previousValue = display;
    }
    operation = op;
    shouldResetDisplay = true;
  }

  void calculate() {
    if (previousValue.isEmpty || operation.isEmpty) return;

    double prev = double.parse(previousValue);
    double current = double.parse(display);
    double result = 0;

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
        result = current != 0 ? prev / current : 0;
        break;
      default:
        return;
    }

    display = result % 1 == 0 ? result.toInt().toString() : result.toString();
    previousValue = '';
    operation = '';
    shouldResetDisplay = true;
  }

  void handleEquals() {
    calculate();
  }

  void handleClear() {
    display = '0';
    previousValue = '';
    operation = '';
    shouldResetDisplay = false;
  }

  void handleDecimal() {
    if (!display.contains('.')) {
      display = '$display.';
      shouldResetDisplay = false;
    }
  }
}
