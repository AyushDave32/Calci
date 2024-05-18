import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Internship Task-01',
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String answer = "";
  double n1 = 0.0;
  double n2 = 0.0;
  String operation = "";
  bool isOperatorPressed = false;

  void buttonPressed(String buttonText) {
    if (buttonText == "CLR") {
      output = "0";
      answer = "";
      n1 = 0.0;
      n2 = 0.0;
      operation = "";
      isOperatorPressed = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      if (isOperatorPressed) {
        return;
      }
      n1 = double.parse(answer.isEmpty ? "0" : answer);
      operation = buttonText;
      answer = "";
      output = output + buttonText;
      isOperatorPressed = true;
    } else if (buttonText == ".") {
      if (answer.contains(".")) {
        return;
      } else {
        answer = answer + buttonText;
        output = output + buttonText;
      }
    } else if (buttonText == "=") {
      n2 = double.parse(answer.isEmpty ? "0" : answer);

      switch (operation) {
        case "+":
          answer = (n1 + n2).toStringAsFixed(2);
          break;
        case "-":
          answer = (n1 - n2).toStringAsFixed(2);
          break;
        case "*":
          answer = (n1 * n2).toStringAsFixed(2);
          break;
        case "/":
          answer = (n1 / n2).toStringAsFixed(2);
          break;
        default:
          answer = "0";
          break;
      }
      output = answer;
      n1 = 0.0;
      n2 = 0.0;
      operation = "";
      isOperatorPressed = false;
    } else if (buttonText == "⌫") {
      if (answer.isNotEmpty) {
        answer = answer.substring(0, answer.length - 1);
        output = output.substring(0, output.length - 1);
      }
    } else {
      if (answer == "0") {
        answer = buttonText;
      } else {
        answer = answer + buttonText;
      }
      output = output + buttonText;
      isOperatorPressed = false;
    }

    setState(() {
      output = output;
      answer = answer;
    });
  }

  Widget operationButton(String buttonText) {
    return Expanded(
      child: MaterialButton(
        padding: const EdgeInsets.all(25.5),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
        color: Colors.deepPurpleAccent,
        textColor: Colors.yellowAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(child: Divider()),
            Column(
              children: [
                Row(children: [
                  operationButton("1"),
                  operationButton("2"),
                  operationButton("3"),
                  operationButton("+")
                ]),
                Row(children: [
                  operationButton("4"),
                  operationButton("5"),
                  operationButton("6"),
                  operationButton("-")
                ]),
                Row(children: [
                  operationButton("7"),
                  operationButton("8"),
                  operationButton("9"),
                  operationButton("/")
                ]),
                Row(children: [
                  operationButton("."),
                  operationButton("0"),
                  operationButton("00"),
                  operationButton("*")
                ]),
                Row(
                  children: [
                    operationButton("CLR"),
                    operationButton("="),
                    operationButton("⌫") // Backspace button
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
