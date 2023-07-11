import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = '0';
  String result = '=0';
  String operator = '';
  bool satisfy = true;
  int count = 0;

  void setNumber(String value) {
    setState(() {
      count = input.length - 1;
      if (result != 'Invalid') {
        if (['×', '÷', '+', '–'].contains(value)) {
          // //debugPrint("HAI");
          operator = value;
          if (count != 0 &&
              ['×', '÷', '+', '–'].contains(input[input.length - 1])) {
           input = input.substring(0, input.length - 1) + value;
          } else if (count != 0) {
            input += value;
          }
        } else {
          if (count == 0) {
            input = ' $value';
            
          } else {
            input += value;
          }
          double a = evaluateExpression(input.trim());
          ////debugPrint("$a");
          try {
            int convertedInt = a.toInt();
            result = (convertedInt < a) ? '$a' : '$convertedInt';
          } catch (e) {
            result = '$a';
          }
        }
      }
    });
  }

  double evaluateExpression(String expression) {
    if (expression.isNotEmpty) {
      expression = expression.replaceAll(' ', '');

      List<String> numbers = [];
      List<String> operators = [];
      String currentNumber = '';
      
      for (int i = 0; i < expression.length; i++) {
        String char = expression[i];

        if (char == '+' || char == '–' || char == '×' || char == '÷') {
          numbers.add(currentNumber);
          currentNumber = '';
          operators.add(char);
        } else {
          currentNumber += char;
        }
      }
      numbers.add(currentNumber);

      // Perform multiplication and division operations
      for (int i = 0; i < operators.length; i++) {
        if (operators[i] == '×' || operators[i] == '÷') {
          double leftOperand = double.parse(numbers[i]);
          double rightOperand = double.parse(numbers[i + 1]);
          double results = 0.0;

          if (operators[i] == '×') {
            results = leftOperand * rightOperand;
          } else if (operators[i] == '÷') {
            try {
              results = leftOperand / rightOperand;
            } catch (e) {
              result = 'Invalid';
            }
          }

          numbers[i] = results.toString();
          numbers.removeAt(i + 1);
          operators.removeAt(i);
          i--;
        }
      }

      // Perform addition and subtraction operations
      
      double results = double.parse(numbers[0]);

      for (int i = 0; i < operators.length; i++) {
        double operand = double.parse(numbers[i + 1]);

        if (operators[i] == '+') {
          results += operand;
        } else if (operators[i] == '–') {
          results -= operand;
        }
      }

      return results;
    } else {
      return 0;
    }
  }

 

  void setResult(String value) {
    setState(() {
      result = value;
    });
  }

  void clearInput() {
    setState(() {
      input = '0';
      result = '0';
      operator = '';
      satisfy = true;
      count = 0;
    });
  }

  void removeLast() {
    setState(() {
      if (input.length == 1) {
        input = '0';
      } else {
        input = input.substring(0, input.length - 1);
      }

      if (result.length == 1) {
        result = '0';
        operator = '';
        satisfy = true;
        count = 0;
      } else {
        removelastResult();
      }
    });
  }

  void removelastResult() {
    setState(() {
      if (['×', '÷', '+', '–'].contains(input[input.length - 1])) {

        double a =
            evaluateExpression(input.trim().substring(0, input.length - 2));
        
        int convertedInt = a.toInt();
        result = (convertedInt < a) ? '$a' : '$convertedInt';
      } else {
        double a = evaluateExpression(input.trim());
        
        int convertedInt = a.toInt();
        result = (convertedInt < a) ? '$a' : '$convertedInt';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 19.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    result,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 19.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    input,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 2.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setNumber('7');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '7',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('8');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '8',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('9');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '9',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('÷');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '÷',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Second Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setNumber('4');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '4',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('5');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '5',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('6');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '6',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('×');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '×',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Third Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setNumber('1');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '1',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('2');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '2',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('3');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '3',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('–');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '-',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Fourth Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // delete previous
                          if (input != '0') {
                            removeLast();
                          }
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Icon(Icons.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('0');
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '0',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // setNumber('+');
                          clearInput();
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Icon(Icons.delete),
                      ),
                      TextButton(
                        onPressed: () {
                          setNumber('+');
                          operator = '+';
                        },
                        style:
                            TextButton.styleFrom(shape: const CircleBorder()),
                        child: const Text(
                          '+',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       ElevatedButton(
                  //         onPressed: () {},
                  //         child: const Text('='),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
