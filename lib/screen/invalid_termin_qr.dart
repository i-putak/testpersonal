import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';

class InvalidTerminQr extends StatelessWidget {
  const InvalidTerminQr({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Probe anlegen', 
          style: TextStyle(fontSize: 25,),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Container(
          padding: EdgeInsets.all(60),
          child: Text('Ungültiger Termin-QR-Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          )),
        ),

        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30, right:30, top:20, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(900, 100),
                  maximumSize: const Size(900, 100),
                  primary: Colors.lightBlueAccent,
                  shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: MyHomePage(),
                        type: PageTransitionType.rightToLeft),
                    (route) => false
                  );
                }, 
                child: Text('Erneut scannen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ))
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 30, right:30, top:20, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(900, 100),
                  maximumSize: const Size(900, 100),
                  primary: Color.fromARGB(255, 218, 217, 217),
                  shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: MyHomePage(),
                        type: PageTransitionType.rightToLeft),
                    (route) => false
                  );
                }, 
                child: Text('Abbrechen',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ))
              ),
            ),
          ]
        )
      ],)
    );
  }
}