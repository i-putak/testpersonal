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
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF020000)),
        home: ListView(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            children: const <Widget>[MyHomePage()]));
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: QRViewExample(type:'Probe'),
                    type: PageTransitionType.rightToLeft),
                // )
              );
            },
            child: const Text('Neue Probe anlegen'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: ViewSchedule(),
                    type: PageTransitionType.rightToLeft),
                // )
              );
            },
            child: const Text('Terminliste anzeigen'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(900, 100),
              maximumSize: const Size(900, 100),
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
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
            child: const Text('eNAT für Retesting erstellen'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
