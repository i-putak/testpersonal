import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:testpersonal/screen/ergebnis_eingeben.dart';
import 'package:testpersonal/screen/retesting.dart';
import 'package:testpersonal/screen/scanner_onetime.dart';
import 'package:testpersonal/screen/scanner_multiple.dart';
import 'package:testpersonal/screen/schedules.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Testpersonal-Ansicht',
        theme: ThemeData.dark().copyWith(
            primaryColor: Color.fromARGB(255, 104, 188, 228),
            accentColor: Color.fromARGB(255, 202, 67, 57),
            
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.lightBlueAccent,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              )
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 104, 188, 228),
                shadowColor: Color.fromARGB(255, 0, 174, 255),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                minimumSize: Size(600,100),
                maximumSize: Size(600,100),
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              )
            ),

            textTheme: TextTheme(
              displayMedium: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),

            )

        ),
        home: MyHomePage()
            
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Container(
           padding: EdgeInsets.only(top:120),
           child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: QRViewExample(type:'Probe'),
                        type: PageTransitionType.rightToLeft),
                    // )
                  );
                },
                child: const Text('Neue Probe'),
              ),
         ),
          
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: MultipleScanner(5, 'eNAT'),
                        type: PageTransitionType.rightToLeft),
                    (route) => false
                    // )
                    );
              },
              child: const Text('eNAT erstellen'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(3, 'Kartusche'),
                      type: PageTransitionType.rightToLeft),
                  (route) => false
                  // )
                  );
            },
            child: const Text('Kartusche erstellen'),
          ),
          
          ElevatedButton(
           onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: QRViewExample(type:'Kartusche'),
                    type: PageTransitionType.rightToLeft),
                (route) => false,
                // )
              );
            },
            child: const Text('Ergebnis eingeben'),
          ),
          
          Container(
            
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: const Retesting(),
                        type: PageTransitionType.rightToLeft),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Retesting'),
              ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 120),
            child: ElevatedButton(
              
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: ViewSchedule(),
                      type: PageTransitionType.rightToLeft),
                  // )
                );
              },
              child: const Text('Terminliste'),
            ),
          ),
          
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
