import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testpersonal/screen/ergebnis_eingeben.dart';
import 'package:testpersonal/screen/retesting.dart';
import 'package:testpersonal/screen/scanner_onetime.dart';
import 'package:testpersonal/screen/auto_scanner.dart';
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
            primaryColor: Color.fromARGB(255, 128, 214, 255),
            //accentColor: Color.fromARGB(255, 202, 67, 57),
            buttonTheme: ButtonTheme.of(context).copyWith(
                textTheme: ButtonTextTheme.accent,
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(secondary: Color.fromARGB(255, 128, 214, 255)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 74, 74, 74),
              elevation: 5,
              side: BorderSide(
                color: Color.fromARGB(255, 128, 214, 255),
                width: 3.0,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minimumSize: Size(600, 90),
              maximumSize: Size(600, 90),
              textStyle: TextStyle(
                  color: Color.fromARGB(255, 128, 214, 255),
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            )),
            textTheme: TextTheme(
              displayMedium: TextStyle(
                color: Color.fromARGB(255, 128, 214, 255),
                fontSize: 20,
              ),
            )),
        home: MyHomePage());
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
            padding: EdgeInsets.only(top: 120),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: QRViewExample(type: 'Probe'),
                      type: PageTransitionType.rightToLeft),
                  // )
                );
              },
              icon: FaIcon(
                // <-- Icon
                FontAwesomeIcons.vial,
                size: 38.0,
                color: Color.fromARGB(255, 128, 214, 255),
              ),
              label: Text('Probe erstellen'), // <-- Text
            ),
          ),
          Container(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: QrMultiScanner(type: 'eNAT', amount: 5),
                        type: PageTransitionType.rightToLeft),
                    (route) => false
                    // )
                    );
                /* icon: Icon(Icons.save),  //icon data for elevated button
                label: Text("Elevated Button with Icon"), */
              },
              icon: FaIcon(
                  // <-- Icon
                  FontAwesomeIcons.vials,
                  size: 45.0,
                  color: Color.fromARGB(255, 128, 214, 255)),
              label: Text('eNAT erstellen'), // <-- Text
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: QrMultiScanner(type: 'Kartusche', amount: 3),
                      type: PageTransitionType.rightToLeft),
                  (route) => false
                  // )
                  );
            },
            icon: Icon(
                // <-- Icon
                Icons.add_card,
                size: 45.0,
                color: Color.fromARGB(255, 128, 214, 255)),
            label: Text('Kartusche erstellen'), // <-- Text
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: QRViewExample(type: 'Kartusche'),
                    type: PageTransitionType.rightToLeft),
                (route) => false,
                // )
              );
            },
            icon: Icon(
                // <-- Icon
                Icons.create_outlined,
                size: 45.0,
                color: Color.fromARGB(255, 128, 214, 255)),
            label: Text('Ergebnis eingeben'), // <-- Text
          ),
          ElevatedButton.icon(
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
            icon: Icon(
                // <-- Icon
                Icons.redo,
                size: 45.0,
                color: Color.fromARGB(255, 128, 214, 255)),
            label: Text('Retesting'), // <-- Text
          ),
          Container(
            padding: EdgeInsets.only(bottom: 120),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: ViewSchedule(),
                      type: PageTransitionType.rightToLeft),
                  // )
                );
              },
              icon: Icon(
                  // <-- Icon
                  Icons.calendar_month,
                  size: 45.0,
                  color: Color.fromARGB(255, 128, 214, 255)),
              label: Text('Terminliste'), // <-- Text
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
