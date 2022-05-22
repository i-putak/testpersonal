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
  Map<int, int> values ={
    1234 : 1,
    2345 : 2,
    4567 : 3,
    6789 : 4
  };

  int _selected = 1;
  int _idValue = 1;

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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.white,
              width: 500.0,
              height: 400.0,
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[bodyContent()],
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

  bodyContent() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: values.keys.map((int key){
        return RadioListTile<int>(
            title: Text('eNAT-ID: ' + '${key}',
              style: const TextStyle(
                fontSize: 35,
                color: Colors.black
              )
            ),
            activeColor: Colors.blue,
            value: values[key]??_selected,
            groupValue: _selected,
            onChanged: (int? value){
              setState(() {
                _selected = value??_selected;
                _idValue = key;
              });
            }
        );
      }).toList(),
    );
  }
}
