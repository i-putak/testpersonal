import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';


class KartuschenQRCode extends StatefulWidget {
  const KartuschenQRCode({Key? key}) : super(key: key);

  @override
  State<KartuschenQRCode> createState() => _KartuschenQRCodeState();
}

class _KartuschenQRCodeState extends State<KartuschenQRCode> {
  final controller = TextEditingController();

  String _text = "Kartuschen-ID: 25";

  @override
  Widget build(BuildContext context) {
    print(controller.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ergebnis eingeben'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              color: Colors.black,
              width: 900.0,
              height: 85.0,
              alignment: Alignment.topLeft,
              child: const Text("Kartuschen-QR-Code enthällt folgende eNATs:",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white
                  ),),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Colors.black,
              width: 900.0,
              height: 100.0,
              alignment: Alignment.topLeft,
              child: Text(_text,
                style: const TextStyle(
                    fontSize: 27,
                    color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
              color: Colors.black,
              width: 900.0,
              height: 80.0,
              alignment: Alignment.topLeft,
              child: const Text("Drucken Sie bitte den Kartuschen-QR-Code aus und kleben Sie ihn auf die Kartusche:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ),
                  ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              width: 250.0,
              height: 250.0,
              alignment: Alignment.topLeft,
              child: QrImage(
                data: controller.text,
                version: QrVersions.auto,
                size: 250,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 80),
                maximumSize: const Size(900, 80),
                primary: Colors.white,
                onPrimary: Colors.black,
                shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const MyHomePage(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Zurück'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 80),
                maximumSize: const Size(900, 80),
                primary: Colors.lightBlueAccent,
                onPrimary: Colors.white,
                shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      //hier soll verbindng mit http sein
                      child: const MyHomePage(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Drucken'),
            ),
          ]
        ),
      )
    );
  }
}


