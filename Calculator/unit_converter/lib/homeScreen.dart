// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Widget buttons(String Btext, Color Bcolor, Color Tcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(Btext);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Bcolor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10)),
        child: Text(
          Btext,
          style: TextStyle(color: Tcolor, fontSize: 35),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    text + opr,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 60),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons('C', Colors.grey.shade800,
                    const Color.fromARGB(255, 183, 36, 25)),
                buttons('()', Colors.grey.shade800, Colors.green),
                buttons('%', Colors.grey.shade800, Colors.green),
                buttons('/', Colors.grey.shade800, Colors.green),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons('7', Colors.grey.shade800, Colors.white),
                buttons('8', Colors.grey.shade800, Colors.white),
                buttons('9', Colors.grey.shade800, Colors.white),
                buttons('x', Colors.grey.shade800, Colors.green),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons('4', Colors.grey.shade800, Colors.white),
                buttons('5', Colors.grey.shade800, Colors.white),
                buttons('6', Colors.grey.shade800, Colors.white),
                buttons('-', Colors.grey.shade800, Colors.green),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons('1', Colors.grey.shade800, Colors.white),
                buttons('2', Colors.grey.shade800, Colors.white),
                buttons('3', Colors.grey.shade800, Colors.white),
                buttons('+', Colors.grey.shade800, Colors.green),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons('+/-', Colors.grey.shade800, Colors.white),
                buttons('0', Colors.grey.shade800, Colors.white),
                buttons('.', Colors.grey.shade800, Colors.white),
                buttons('=', Colors.green, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(Btext) {
    if (Btext == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && Btext == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (Btext == '+' ||
        Btext == '-' ||
        Btext == 'x' ||
        Btext == '/' ||
        Btext == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = Btext;
      result = '';
    } else if (Btext == '%') {
      result = numOne / 100;
      finalResult = checkDecimal(result);
    } else if (Btext == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (Btext == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + Btext;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return checkDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return checkDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return checkDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return checkDecimal(result);
  }

  String checkDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
