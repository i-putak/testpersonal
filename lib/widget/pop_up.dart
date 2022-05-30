import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screen/scanner_multiple.dart';
import '../screen/scanner_onetime.dart';

Widget pop_up(BuildContext context, String scanned, String type, int amount, int index) {
  //scanned = welcher QR-ode gescannt wurde = falsches QR-Code

  //wenn scanned = K, es wurde (falschlicherweiße) einen Kartuschen-QR-Code gescannt
  //wenn scanned = E, es wurde (falschlicherweiße) einen eNAT-QR-Code gescannt
  //wenn scanned = P, es wurde (falschlicherweiße) einen Proben-QR-Code gescannt
  //wenn scanned = T, es wurde (falschlicherweiße) einen Termin-QR-Code gescannt


  //type = was gescannt werden soll = richtiges QR-Code

  //wenn type = Termin, dann erstellen wir eine neue Probe (OnetimeScanner Aufruf)
  //wenn type = Probe, dann erstellen wir einen neuen eNAT (MultipleScanner Aufruf)
  //wenn type = eNAT, dann erstellen wir eine neue Kartusche (MultipleScanner Aufruf)
  //wenn type = Kartusche, dann erstellen wir ein Ergebnis (OnetimeScanner Aufruf)



  String hilfeTitel = 'Falscher QR-Code';
  String fehler = '';
  String hilfeText = '';

  if (scanned == 'K') {
    fehler = 'Sie haben einen Kartuschen-QR-Code gescannt.';
  } else if (scanned =='E') {
    fehler = 'Sie haben einen eNAT-QR-Code gescannt.';
  } else if (scanned =='P') {
    fehler = 'Sie haben einen Proben-QR-Code gescannt.';
  } else if (scanned =='T') {
    fehler = 'Sie haben einen Termin-QR-Code gescannt.';
  } else if (scanned =='R') {
    fehler = 'Sie haben einen Retest-QR-Code gescannt.';
  }

  if (type == 'Kartusche') {
    hilfeText = 'Scannen Sie bitte einen Kartuschen- oder Retest-QR-Code.';
  } else if (type =='eNAT') {
    hilfeText = 'Scannen Sie bitte einen eNAT-QR-Code.';
  } else if (type =='Probe') {
    hilfeText = 'Scannen Sie bitte einen Proben-QR-Code.';
  } else if (type =='Termin') {
    hilfeText = 'Scannen Sie bitte einen Termin-QR-Code.';
  } 


  return AlertDialog(
    title: Text('${hilfeTitel}\n', 
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    )),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${fehler}', 
        style: TextStyle(
          fontSize: 22,
        )),
        Text('${hilfeText}\n', 
        style: TextStyle(
          fontSize: 22,
        )),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          if (type == 'Kartusche') {
            Navigator.pop(
                  context,
                  PageTransition(
                      child: QRViewExample(type: 'Kartusche'),
                      type: PageTransitionType.bottomToTop)
              );
          } else if (type == 'eNAT') {
            Navigator.pop(
                  context,
                  PageTransition(
                      child: QrMultiScanner(index: index, type: 'Kartusche', amount: amount),
                      type: PageTransitionType.bottomToTop),
              );
          } else if (type == 'Probe') {
            Navigator.pop(
                  context,
                  PageTransition(
                      child: QrMultiScanner(index: index, type: 'eNAT', amount: amount),
                      type: PageTransitionType.bottomToTop),
              );
          } else if (type == 'Termin') {
            Navigator.pop(
                  context,
                  PageTransition(
                      child: QRViewExample(type: 'Probe'),
                      type: PageTransitionType.bottomToTop),
              );
          } else if (type == 'Retest') {
            Navigator.pop(
                  context,
                  PageTransition(
                      child: QRViewExample(type: 'Retest'),
                      type: PageTransitionType.bottomToTop),
              );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          minimumSize: Size(200,50),
          maximumSize: Size(200,50),
        ),
        child: Text('Schließen', 
        style: TextStyle(
          fontSize: 23,
        )),
      ),
    ],
  );
}