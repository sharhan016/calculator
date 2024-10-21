import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double total = 0;
  double num1 = 0;
  double num2 = 0;
  String operation = "";
  String display = '';
  final buttons = [
    "7",
    "8",
    "9",
    "C",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "0",
    "*",
    "/",
    "="
  ];

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        total = 0;
        num1 = 0;
        num2 = 0;
        display = '';
        operation = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        operation = buttonText;
        display = '';
      } else if (buttonText == "=") {
        if (operation == "+") {
          total = num1 + num2;
        } else if (operation == "-") {
          total = num1 - num2;
        } else if (operation == "*") {
          total = num1 * num2;
        } else if (operation == "/") {
          if (num2 != 0) {
            total = num1 / num2;
          } else {
            display = 'Error';
          }
        }
        num1 = total;
        display = total.toString();
        num2 = 0;
        operation = "";
      } else {
        if (operation.isEmpty) {
          num1 = double.parse(buttonText);
          display = num1.toString();
        } else {
          num2 = double.parse(buttonText);
          display = num2.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        display,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    final value = buttons[index];
                    return roundButton(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roundButton(String text) {
    return GestureDetector(
      onTap: () => buttonPressed(text),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
