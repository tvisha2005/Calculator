import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorAppHome(),
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {

  String equation='0';
  String result='0';
  String expression='';


  buttonPresed(btnText){
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == 'Del') {
        equation = equation.substring(0, equation.length - 1);

        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch (e) {
          'Error';
        }
      }


      else {
        if(equation == '0'){
          equation= btnText;
        }else{
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calButtons (String btnText, Color  txtColor, double btnWidth, Color btnColor ){
    return InkWell(
      onTap: (){
        buttonPresed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 64.5,
        width:btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(btnText, style: TextStyle(color: txtColor, fontSize: 30, fontWeight: FontWeight.w500),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar:  AppBar(
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(150, 100)
              )
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[100],
          title: const Text('DevSoc AppD', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.normal),),
        ),

        body: Column(
            children: [

              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                height: 90,
                width: double.infinity,
                color: Colors.black,
                child: SingleChildScrollView(child: Text(equation,style: TextStyle(color: Colors.blueAccent[100],fontSize: 38, ),)),
              ),


              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                height: 90,
                width: double.infinity,
                color: Colors.black,
                child: SingleChildScrollView(child: Text(result,style: TextStyle(color: Colors.white,fontSize: 60, ),)),
              ),


              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons('AC', Colors.white, 80, Colors.blueAccent[100]!),
                        calButtons('Del', Colors.white, 80, Colors.blueAccent[100]!),
                        calButtons('%', Colors.white, 80, Colors.blueAccent[100]!),
                        calButtons('÷', Colors.white, 80, Colors.blueAccent[100]!),

                      ],
                    ),
                    const SizedBox(height: 25,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons('7', Colors.white, 80, Colors.white38!),
                        calButtons('8', Colors.white, 80, Colors.white38!),
                        calButtons('9', Colors.white, 80, Colors.white38!),
                        calButtons('×', Colors.white, 80, Colors.blueAccent[100]!),

                      ],
                    ),
                    const SizedBox(height: 23,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons('4', Colors.white, 80, Colors.white38!),
                        calButtons('5', Colors.white, 80, Colors.white38!),
                        calButtons('6', Colors.white, 80, Colors.white38!),
                        calButtons('-', Colors.white, 80, Colors.blueAccent[100]!),

                      ],
                    ),
                    const SizedBox(height: 23,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons('1', Colors.white, 80, Colors.white38!),
                        calButtons('2', Colors.white, 80, Colors.white38!),
                        calButtons('3', Colors.white, 80, Colors.white38!),
                        calButtons('+', Colors.white, 80, Colors.blueAccent[100]!),

                      ],
                    ),
                    const SizedBox(height: 23,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButtons('.', Colors.white, 80, Colors.blueAccent[100]!),
                        calButtons('0', Colors.white, 80, Colors.white38!),
                        calButtons('=', Colors.white, 170, Colors.blueAccent[100]!),


                      ],
                    ),
                    const SizedBox(height: 23,),
                  ],
                ),
              ),
            ],
            ),
        );
    }
}
