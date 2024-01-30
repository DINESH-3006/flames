import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Calculate(),
    );
  }
}

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  @override
  State<Calculate> createState() => _CalculateState();
}


class _CalculateState extends State<Calculate> {

String equns="0";
String res='0';
void pressing(String buttonContent){
  if(buttonContent=='AC'){
      res='0';
      equns='0';
  }
  else if(buttonContent=='←'){
      equns=equns.substring(0,equns.length-1);
      if(equns==''){
        equns='0';
      }
  }
  else if(buttonContent=='='){
      String expression=equns;
      expression=expression.replaceAll('÷', '/');
      expression=expression.replaceAll('×', '*');
      Parser parse=Parser();
      Expression exp=parse.parse(expression);
      ContextModel CM=ContextModel();
      res='${exp.evaluate(EvaluationType.REAL, CM)}';
      print(res);
  }
  else{
      if(equns=='0'){
        equns=buttonContent;
      }
      else{
      equns=equns+buttonContent;
      }
  }
}

  Widget buildButton(
      String buttonContent, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * buttonHeight,
      child: TextButton(
        onPressed: () {
          setState(() {
            pressing(buttonContent); 
          });
        },
        child: Text(
          buttonContent,
          style: TextStyle(
              color: buttonColor, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child:  Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  equns,
                  style:const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child:  Padding(
                padding:const EdgeInsets.all(10),
                child: Text(
                  res,
                  style:const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const Expanded(
                child: Divider(
              color: Colors.black,
            )),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton('AC', 0.1, Colors.blue),
                          buildButton('←', .1, Colors.blue),
                          buildButton('÷', .1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('7', .1, Colors.white),
                          buildButton('8', .1, Colors.white),
                          buildButton('9', .1, Colors.white),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('4', .1, Colors.white),
                          buildButton('5', .1, Colors.white),
                          buildButton('6', .1, Colors.white),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('1', .1, Colors.white),
                          buildButton('2', .1, Colors.white),
                          buildButton('3', .1, Colors.white),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('.', .1, Colors.white),
                          buildButton('0', .1, Colors.white),
                          buildButton('00', .1, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Container(
                      child: Column(
                        children: [
                          buildButton('×', 0.1, Colors.blue),
                          buildButton('-', 0.1, Colors.blue),
                          buildButton('+', 0.1, Colors.blue),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  pressing('=');
                                });
                              },
                              backgroundColor: Colors.blue,
                              shape: const CircleBorder(),
                              child: const Text(
                                '=',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
