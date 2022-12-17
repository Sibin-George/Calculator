import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userinput = "";
  String result = "";
  final List<String> ButtonList = [
    'AC',
    'C',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Calculator'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 80,
              width: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userinput,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              width: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.grey[900],
              height: 370,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 2,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10),
                itemBuilder: (BuildContext context, int index) => CustomButton(
                  ButtonList[index],
                ),
                itemCount: ButtonList.length,
              ),
            ),
          ],
        )));
  }

  Widget CustomButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          handlebuttons(text);
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        foregroundColor: buttoncolor[200],
        shape: const CircleBorder(),
      ),
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: getColors(text),
          )),
    );
  }

  getColors(String text) {
    if (text == "C" ||
        text == "%" ||
        text == "÷" ||
        text == "x" ||
        text == "-" ||
        text == "+" ||
        text == "AC" ||
        text == "=") {
      return buttoncolor;
    }
    return Colors.white;
  }

  handlebuttons(String text) {
    if (text == "AC") {
      userinput = "";
      result = "";
      return;
    }
    if (text == "C") {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
        String lastString =
            userinput.substring(userinput.length - 1, userinput.length);
        if (lastString != "%" &&
            lastString != "÷" &&
            lastString != "x" &&
            lastString != "-" &&
            lastString != "+" &&
            lastString != "AC" &&
            lastString != "=") {
          equalPressed();
        }
        return;
      } else {
        return null;
      }
    }
    if (text == '=') {
      userinput = result;
      result = '';
    }
    if (text != '=') {
      userinput = userinput + text;
      String lastString =
          userinput.substring(userinput.length - 1, userinput.length);
      if (lastString != "C" &&
          lastString != "%" &&
          lastString != "÷" &&
          lastString != "x" &&
          lastString != "-" &&
          lastString != "+" &&
          lastString != "AC" &&
          lastString != "=") {
        equalPressed();
      }
    }
  }

  equalPressed() {
    String userInputFC = userinput;
    userInputFC = userInputFC.replaceAll("x", "*");
    userInputFC = userInputFC.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(userInputFC);
    ContextModel ctx = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, ctx);

    result = eval.toString().replaceAll(".0", "");
  }
}

const buttoncolor = Colors.amber;
