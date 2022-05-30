import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';
import 'package:testpersonal/screen/qr_generator_screen.dart';

class Retesting extends StatefulWidget {
  const Retesting({Key? key}) : super(key: key);

  @override
  State<Retesting> createState() => _RetestingState();
}

class _RetestingState extends State<Retesting> {
  //Links sind Keys = eNAT-IDs und die Zahlen rechts sind Radio-Button Auswahl
  //Die eNAT-IDs sollen automatisch von DB eingelesen werden
  Map<int, int> values = {1234: 1, 2345: 2, 4567: 3, 6789: 4};

  int _selected = 1;
  int _idValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Retesting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      padding: EdgeInsets.only(top: 50, left: 50),
                      child: Text(
                        "eNATs die erneut getestet werden müssen:",
                        style: TextStyle(fontSize: 25),
                      )),
                ]),
                Container(
                    padding: EdgeInsets.only(top: 50, left: 50),
                    child: Column(
                      children: <Widget>[bodyContent()],
                    )),
              ],
            ),
            Column(children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 90),
                    maximumSize: const Size(700, 90)),
                onPressed: () {
                  print(_idValue);
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: QrGenerator(id: _idValue, type: 'Kartusche'),
                        type: PageTransitionType.rightToLeft),
                    (route) => false,
                    // )
                  );
                },
                child: const Text('Kartuschen-QR-Code erstellen'),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40, top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(700, 90),
                    maximumSize: const Size(700, 90),
                    onPrimary: Colors.black,
                    primary: Color.fromARGB(255, 228, 227, 227),
                  ),
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
              ),
            ]),
          ],
        ),
      ),
    );
  }

  bodyContent() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: values.keys.map((int key) {
        return RadioListTile<int>(
            title: Text('eNAT-ID: ' + '${key}',
                style: const TextStyle(fontSize: 27)),
            activeColor: Theme.of(context).primaryColor,
            value: values[key] ?? _selected,
            groupValue: _selected,
            onChanged: (int? value) {
              setState(() {
                _selected = value ?? _selected;
                _idValue = key;
              });
            });
      }).toList(),
    );
  }
}
