import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';

class QrGenerator extends StatelessWidget {
  const QrGenerator({Key? key, required this.id, required this.type})
      : super(key: key);

  final int id;
  final String type;

  @override
  Widget build(BuildContext context) {
    String titel = '';
    String text = '';
    String erkennen = '';

    if (type == 'probe') {
      erkennen = 'P_' + id.toString();
      titel = 'Probe anlegen';
      text =
          'Drucken Sie bitte den Proben-QR-Code und händigen Sie ihn dem Teilnehmer aus.';
    } else if (type == 'eNAT') {
      erkennen = 'E_' + id.toString();
      titel = 'eNAT erstellen';
      text =
          'Drucken Sie bitte den eNAT-QR-Code aus und kleben Sie ihn auf das Röhrchen:';
    } else if (type == 'Kartusche') {
      erkennen = 'K_' + id.toString();
      titel = 'Kartusche erstellen';
      text =
          'Drucken Sie bitte den Kartuschen-QR-Code aus und kleben Sie ihn auf die Kartusche:';
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('${titel}', style: TextStyle(fontSize: 25)),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 60, right: 60, left: 60),
                  child: Text('${text}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ))),
              Container(
                child: QrImage(
                  data: erkennen,
                  version: QrVersions.auto,
                  size: 300.0,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 50),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              //Hier soll man mit Drucker verbinden
                              child: MyHomePage(),
                              type: PageTransitionType.rightToLeft),
                          (route) => false
                          // )
                          );
                    },
                    child: Text('Drucken')),
              ),
            ]));
  }
}
