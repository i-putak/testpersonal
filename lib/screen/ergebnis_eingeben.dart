import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:testpersonal/main.dart';

class ErgebnisEingeben extends StatefulWidget {
  const ErgebnisEingeben({Key? key}) : super(key: key);

  @override
  State<ErgebnisEingeben> createState() => _ErgebnisEingebenState();
}

class _ErgebnisEingebenState extends State<ErgebnisEingeben> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Ergebnis eingeben'),
        ),
        body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            final String? code = barcode.rawValue;
            debugPrint('Barcode found! $code');
          }
        ),
    );
  }
}

class ErgebnisAuswaehlen extends StatefulWidget {
  const ErgebnisAuswaehlen({Key? key}) : super(key: key);

  @override
  State<ErgebnisAuswaehlen> createState() => _ErgebnisAuswaehlenState();
}

class _ErgebnisAuswaehlenState extends State<ErgebnisAuswaehlen> {
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
              child: Text("Geben Sie bitte das Testergebnis der Kartusche 1234 ein:",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 120),
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
                      child: const ErgebnisUngueltig(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Ungültig'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 100),
                maximumSize: const Size(900, 100),
                primary: Colors.red,
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
                      child: const ErgebnisPositiv(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Positiv'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 100),
                maximumSize: const Size(900, 100),
                primary: Colors.green,
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
                      child: const ErgebnisNegativ(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Negativ'),
            ),
          ],
        ),
      )
    );
  }
}

class ErgebnisUngueltig extends StatefulWidget {
  const ErgebnisUngueltig({Key? key}) : super(key: key);

  @override
  State<ErgebnisUngueltig> createState() => _ErgebnisUngueltigState();
}

class _ErgebnisUngueltigState extends State<ErgebnisUngueltig> {
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
                child: Text("Bestätigen Sie bitte, dass das Ergebnis der Kartusche UNGÜLTIG ist:",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(900, 100),
                  maximumSize: const Size(900, 100),
                  primary: Colors.blueAccent,
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
                onPressed: () {},
                child: const Text('Bestätigen'),
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
                        child: const ErgebnisAuswaehlen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Zurück'),
              ),
            ],
          ),
        )
    );
  }
}

class ErgebnisPositiv extends StatefulWidget {
  const ErgebnisPositiv({Key? key}) : super(key: key);

  @override
  State<ErgebnisPositiv> createState() => _ErgebnisPositivState();
}

class _ErgebnisPositivState extends State<ErgebnisPositiv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ergebnis eingeben'),
          backgroundColor: Colors.red,
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
                child: Text("Bestätigen Sie bitte, dass das Ergebnis der Kartusche POSITIV ist:",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(900, 100),
                  maximumSize: const Size(900, 100),
                  primary: Colors.blueAccent,
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
                onPressed: () {},
                child: const Text('Bestätigen'),
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
                        child: const ErgebnisAuswaehlen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Zurück'),
              ),
            ],
          ),
        )
    );
  }
}

class ErgebnisNegativ extends StatefulWidget {
  const ErgebnisNegativ({Key? key}) : super(key: key);

  @override
  State<ErgebnisNegativ> createState() => _ErgebnisNegativState();
}

class _ErgebnisNegativState extends State<ErgebnisNegativ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ergebnis eingeben'),
          backgroundColor: Colors.green,
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
                child: Text("Bestätigen Sie bitte, dass das Ergebnis der Kartusche NEGATIV ist:",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(900, 100),
                  maximumSize: const Size(900, 100),
                  primary: Colors.blueAccent,
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
                        child: const NegativeAnzeigen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Bestätigen'),
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
                        child: const ErgebnisAuswaehlen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Zurück'),
              ),
            ],
          ),
        )
    );
  }
}

class NegativeAnzeigen extends StatefulWidget {
  const NegativeAnzeigen({Key? key}) : super(key: key);

  @override
  State<NegativeAnzeigen> createState() => _NegativeAnzeigenState();
}

class _NegativeAnzeigenState extends State<NegativeAnzeigen> {
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
                width: 600.0,
                height: 100.0,
                alignment: Alignment.topLeft,
                child: Text(
                    "eNATs, die mit diesem Pooltest NEGATIV getestet wurden:",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.black,
                width: 250.0,
                height: 250.0,
                alignment: Alignment.centerLeft,
                child: Text("eNAT-ID: 1234\neNAT-ID: 2345\neNAT-ID: 3456",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.black,
                width: 600.0,
                height: 70.0,
                alignment: Alignment.topLeft,
                child: Text("Dies eNATs dürfen Sie jetzt entsorgen.",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
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
                        child: const MyHomePage(),
                        type: PageTransitionType.rightToLeft),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Bestätigen'),
              ),
            ],
          ),
        )
    );
  }
}
