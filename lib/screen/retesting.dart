import 'package:flutter/material.dart';

class Retesting extends StatefulWidget {
  const Retesting({Key? key}) : super(key: key);

  @override
  State<Retesting> createState() => _RetestingState();
}

class _RetestingState extends State<Retesting> {

  @override
  Widget build(BuildContext context) {

    bool _isChecked = false;

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
            CheckboxListTile(
              title: const Text(
                  "eNat-ID: 1234",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              checkColor: Colors.green,
              activeColor: Colors.transparent,
              value: _isChecked,
              //shape: CircleBorder(),
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
