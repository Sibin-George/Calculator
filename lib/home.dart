import 'dart:developer';

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
  List<String> ButtonList = [
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
              height: 100,
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
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
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
        foregroundColor: buttoncolor[00],
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
        return;
      } else {
        return null;
      }
    }
    if (text=='=') {
      equalPressed();
    }

    if (userinput.endsWith(".0")) {
      userinput = userinput.replaceAll(".0", "");
    }

    if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
    }
    userinput = userinput + text;
    return;
  }

  void equalPressed() {
print(userinput);
    String finaluserinput = userinput;
    finaluserinput = userinput.replaceAll('x', '*');

    finaluserinput = userinput.replaceAll('÷', '/');
print(finaluserinput);
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}

const buttoncolor=Colors.amber;
