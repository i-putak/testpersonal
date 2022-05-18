import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';
import 'package:testpersonal/screen/kartuschen_qr_code.dart';

class Retesting extends StatefulWidget {
  const Retesting({Key? key}) : super(key: key);

  @override
  State<Retesting> createState() => _RetestingState();
}

class _RetestingState extends State<Retesting> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ergebnis eingeben'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.black,
              width: 900.0,
              height: 100.0,
              alignment: Alignment.topLeft,
              child: Text("eNAts die erneut getestet werden müssen:",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              width: 500.0,
              height: 300.0,
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[],
              )
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 100),
                maximumSize: const Size(900, 100),
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
              //disabeln kann man wenn hier null steht
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const KartuschenQRCode(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Kartuschen-QR-Code erstellen'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 100),
                maximumSize: const Size(900, 100),
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
              //disabeln kann man wenn hier null steht
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const MyHomePage(),
                      type: PageTransitionType.leftToRight),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Abbrechen'),
            ),
          ],
        ),
      ),
    );
  }
}
