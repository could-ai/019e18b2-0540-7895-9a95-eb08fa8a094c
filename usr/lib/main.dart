import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CalculatorScreen(),
      },
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _currentInput = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      if (_currentInput.isNotEmpty) {
        _num1 = double.parse(_currentInput);
        _operand = buttonText;
        _currentInput = "";
      }
    } else if (buttonText == "=") {
      if (_currentInput.isNotEmpty && _operand.isNotEmpty) {
        _num2 = double.parse(_currentInput);

        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = (_num2 != 0 ? (_num1 / _num2).toString() : "Error");
            break;
        }

        // Clean up trailing .0 for whole numbers
        if (_output.endsWith(".0")) {
          _output = _output.substring(0, _output.length - 2);
        }

        _currentInput = _output;
        _operand = "";
      }
    } else {
      if (buttonText == "." && _currentInput.contains(".")) {
        return; // Prevent multiple decimals
      }
      _currentInput = _currentInput + buttonText;
      _output = _currentInput;
    }

    setState(() {
      _output = _output;
    });
  }

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.surfaceContainerHighest,
            foregroundColor: textColor ?? Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Text(
                  _output,
                  style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("C", color: Colors.redAccent.withOpacity(0.2), textColor: Colors.redAccent),
                      _buildButton("÷", color: Theme.of(context).colorScheme.primaryContainer),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("×", color: Theme.of(context).colorScheme.primaryContainer),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("-", color: Theme.of(context).colorScheme.primaryContainer),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("+", color: Theme.of(context).colorScheme.primaryContainer),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0"),
                      _buildButton("."),
                      _buildButton("=", color: Theme.of(context).colorScheme.primary, textColor: Theme.of(context).colorScheme.onPrimary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
