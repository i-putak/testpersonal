import 'package:flutter/material.dart';

Widget pop_up(BuildContext context, String type) {
  String hilfeTitel = '';
  String hilfeText = '';
  if (type == 'K') {
    hilfeTitel = 'Falscher QR-Code';
    hilfeText = 'Bitte scannen Sie einen Proben-QR-Code';
  } else if (type =='E') {
    hilfeTitel = 'Falscher QR-Code';
    hilfeText = 'Bitte scannen Sie einen Proben-QR-Code';
  } else if (type =='P') {
    hilfeTitel = 'Falscher QR-Code';
    hilfeText = 'Bitte scannen Sie einen Kartuschen-QR-Code';
  } else if (type =='T') {
    hilfeTitel = 'Falscher QR-Code';
    hilfeText = 'Bitte scannen Sie einen Kartuschen-QR-Code';
  }


  return AlertDialog(
    title: Text('${hilfeTitel}'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${hilfeText}'),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor
        ),
        child: Text('Schließen'),
      ),
    ],
  );
}