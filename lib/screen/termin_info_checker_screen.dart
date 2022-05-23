import 'package:flutter/material.dart';
import 'package:testpersonal/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

import './qr_generator_screen.dart';
import '../main.dart';

class TerminInfoChecker extends StatelessWidget {
  const TerminInfoChecker({ Key? key, required this.terminId }) : super(key: key);

  final String terminId;

  @override
  Widget build(BuildContext context) {
    //Folgende Daten soll man mit einemGET Request von DB bekommen:
    //Teilnehmer Daten
    String vorname = 'Max';
    String nachname = 'Mustermann';
    DateTime geburtsdatum = DateTime(2005, 4, 13);
    String email = 'max.mustermann@web.de';
    String telefonnummer = '016211156987';
    String klasse = '7b';

    //Termin Daten
    DateTime datumZeit = DateTime(2022, 3, 29, 9, 15);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Probe anlegen', style: TextStyle(fontSize: 25)),
        actions: <Widget> [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.help))
        ],
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          //Dummy statische Daten die aus der DB eingelesen werden sollen:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 60, top: 50, bottom: 20, right: 60),
              child: Text('Termin: ' + '${DateFormat('dd.MM.yyyy HH:mm').format(datumZeit)}' + ' Uhr',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              )),
            ),
            Container(
              padding: EdgeInsets.only(left: 60, top: 20, bottom: 20, right: 60),
              child: Text('Überprüfen Sie bitte die Teilnehmerdaten anhand eines Lichbildausweises:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                ))
            ),
            Container(
              padding: EdgeInsets.only(left: 60, top: 20, bottom: 20, right: 60),
              child: Text('''TerminId:  ${terminId}
Name:  ${nachname}
Vorname:  ${vorname}
Geburtsdatum:  ${DateFormat('dd.MM.yyyy').format(geburtsdatum)}
E-mail:  ${email}
Tel.-Nr:  ${telefonnummer}
Klasse:  ${klasse}''',maxLines: 20, style: TextStyle(fontSize: 28 ,color: Colors.white) , 
              ),
            )

          ],),

      

          Column(children: [
            Container(
              padding: EdgeInsets.only(left: 30, right:30, top:20, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                
                onPressed: () {
                  //hier soll man einen POST an DB schicken um eine Probe anzulegen
                  //als Response soll hier einen ProbenId kommen
                  int probenId = 4;

                  

                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: QrGenerator(id: probenId, type: 'probe'),
                        type: PageTransitionType.rightToLeft),
                        (route) => false
                    // )
                  );
                }, 
                child: Text('Bestätigen')
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right:30, top:10, bottom: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 228, 227, 227),
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
          ],
        )]
      )
    );
  }
}