import 'package:flutter/material.dart';

void main() => runApp(Calcu());

class Calcu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator> {
  String numbers = "", numtemp = "", result = "", optemp = " ", op = " ", tempnum = "";
  num num2 = 0, num1 = 0, tempres = 0;
  int equalP = 0, dotCount = 0, opLast = 0, opRepeat = -1;

  buttonPressed(String data) {
    if (data == "+" || data == "/" || data == "*" || data == "-") {
      opLast = 1;
    } else {
      if (data != "=") {
        opLast = 0;
      }
    }
    if (equalP == 1 && data != "-" && data != "/" && data != "+" && data != "=" && data != "AC" && data != "*" && data != ".") {
      setState(() {
        equalP = 0;
        numbers = "";
        result = "";
        num1 = 0;
        num2 = 0;
        op = " ";
      });
    } else {
      equalP = 0;
    }
    if (data != "=") {
        if (data == ".") {
          if (dotCount < 1) {
           setState(() {
             numbers = numbers + data;
           }); 
          }
        } else {
          if (data != "+" && data != "-" && data != "*" && data != "/") {
            setState(() {
             numbers = numbers + data;
           });
            opRepeat = 0;
          } else {
            if (opRepeat == 0) {
              setState(() {
                numbers = numbers + data;
              });
            } else if (opRepeat == -1) {
            } else {
              for (int x = 0; x < numbers.length - 1; x++) {
                tempnum = tempnum + numbers[x];
              }
              tempnum = tempnum + data;
              setState(() {
                numbers = tempnum;
              });
              
              tempnum = "";
            }
          }
        }
    }
    if (data != "-" && data != "/" && data != "+" && data != "=" && data != "AC" && data != "*") {
      if (data == ".") {
        if (dotCount == 0) {
          numtemp = numtemp + data;
          dotCount++;
        }
      } else {
        numtemp = numtemp + data;
      }
    } else {
      if (data == "+" || data == "=" || data == "-" || data == "/" || data == "*" || data == "AC") {
        operatorPressed(data);
        if (opRepeat == -1) {
          opRepeat = -1;
        }else if (data=="=" && opRepeat != 1){
          opRepeat = 0;
        } else {
          opRepeat = 1;
        }
      }
    }
  }

  operatorPressed(String data) {
    if (data == "+" || data == "-" || data == "/" || data == "*") {
      dotCount = 0;
      if (op == " ") {
        op = data;
      } else {
        optemp = data;
      }
    }
    if (numtemp != "") {
      if (num1 == 0) {
        num1 = num.parse(numtemp);
        numtemp = "";
      } else {
        num2 = num.parse(numtemp);
        numtemp = "";
      }
    }
    if (op == "+") {
      tempres = num1 + num2;
      num2 = 0;
      num1 = tempres;
      result = "";
      if (optemp != " ") {
        op = optemp;
      }
    } else if (op == "-") {
      tempres = num1 - num2;
      num2 = 0;
      num1 = tempres;
      result = "";
      if (optemp != " ") {
        op = optemp;
      }
    } else if (op == "/") {
      if (num2 == 0) {
        num2 = 1;
      }
      tempres = num1 / num2;
      num2 = 0;
      num1 = tempres;
      result = "";
      if (optemp != " ") {
        op = optemp;
      }
    } else if (op == "*") {
      if (num2 == 0) {
        num2 = 1;
      }
      tempres = num1 * num2;
      num2 = 0;
      num1 = tempres;
      result = "";
      if (optemp != " ") {
        op = optemp;
      }
    }
    if (data == "=") {
      if (opLast == 0) {
        equalP = 1;
        setState(() {
          result = numbers + "=";
          numbers = tempres.toString();
        });
        num2 = 0;
        optemp = " ";
        op = " ";
      } else {}
    } else if (data == "AC") {
      tempnum = "";
      opRepeat = -1;
      numbers = "";
      numtemp = "";
      result = "";
      optemp = " ";
      op = " ";
      num2 = 0;
      num1 = 0;
      tempres = 0;
      equalP = 0;
      dotCount = 0;
      setState(() {
        numbers = "";
        result = "";
      });
    }
  }

  Widget buttons(String data,int color) {
    return Expanded(
      child: OutlineButton(
        child: Text(data,
            style: TextStyle(fontSize: 20)),
        onPressed: () => buttonPressed(data),
        textColor: color == 1 ? Colors.black : Colors.deepOrange,
        padding: EdgeInsets.symmetric(
          vertical: 35.0
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[Expanded(child: Container()),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(this.result,
                      style: TextStyle(
                          fontSize: 25, 
                          ))),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(this.numbers,
                      style: TextStyle(
                          fontSize: 50, color: Colors.deepOrange))),
                  
              Row(children: [
                buttons("1",1),
                buttons("2",1),
                buttons("3",1),
                buttons("+",2)
              ]),
              Row(children: [
                buttons("4",1),
                buttons("5",1),
                buttons("6",1),
                buttons("-",2)
              ]),
              Row(children: [
                buttons("7",1),
                buttons("8",1),
                buttons("9",1),
                buttons("*",2)
              ]),
              Row(children: [
                buttons("0",1),
                buttons("00",1),
                buttons(".",1),
                buttons("/",2)
              ]),
              Row(children: [buttons("AC",2), buttons("=",2)]),
            ],
          ),
        ));
  }
}
