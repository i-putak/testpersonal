import 'package:flutter/material.dart';
import 'package:testpersonal/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/appointment.dart';
import '../models/user.dart';
import './qr_generator_screen.dart';
import '../main.dart';

class TerminInfoChecker extends StatelessWidget {
  Future<int> _createProbe(int terminId) async {
    var uri =
        //Pfad ändern
        Uri.http('10.0.2.2:8080', '/api/createProbe/' + terminId.toString());

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('Probe wurde erstellt');

      Map data = json.decode(response.body);
      int probenId = data['probeId'];
      return probenId;
    } else {
      throw Exception('Probe konnte nicht angelegt werden');
    }
  }

  const TerminInfoChecker(
      {Key? key, required this.appointment, required this.user})
      : super(key: key);

  final AppointmentDetails appointment;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Probe anlegen', style: TextStyle(fontSize: 25)),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.help))
          ],
        ),
        body: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 60, top: 50, bottom: 20, right: 60),
                    child: Text(
                        'Termin: ' +
                            '${DateFormat('dd.MM.yyyy HH:mm').format(appointment.datum)}' +
                            ' Uhr',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        )),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: 60, top: 20, bottom: 200, right: 60),
                      child: const Text(
                          'Überprüfen Sie bitte die Teilnehmerdaten anhand eines Lichbildausweises:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Termin ID:  ", style: TextStyle(fontSize: 28)),
                          Text("Name: ", style: TextStyle(fontSize: 28)),
                          Text("Vorname:  ", style: TextStyle(fontSize: 28)),
                          Text("Geburtsdatum: ",
                              style: TextStyle(fontSize: 28)),
                          Text(
                            "Email:  ",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Tel.-Nr:  ", style: TextStyle(fontSize: 28)),
                          Text("Klasse: ", style: TextStyle(fontSize: 28)),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${appointment.appointmentId}",
                              style: TextStyle(fontSize: 28)),
                          Text(user.name, style: TextStyle(fontSize: 28)),
                          Text(user.vorname, style: TextStyle(fontSize: 28)),
                          Text(
                              DateFormat('dd.MM.yyyy')
                                  .format(user.geburtsdatum),
                              style: TextStyle(fontSize: 28)),
                          Text(user.email, style: TextStyle(fontSize: 28)),
                          Text(user.telefonnummer,
                              style: TextStyle(fontSize: 28)),
                          Text(user.klasse, style: TextStyle(fontSize: 28)),
                        ],
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          _createProbe(appointment.appointmentId)
                              .then((fetechedProbenId) => {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                            child: QrGenerator(
                                                id: fetechedProbenId,
                                                type: 'probe'),
                                            type:
                                                PageTransitionType.rightToLeft),
                                        (route) => false
                                        // )
                                        )
                                  });
                        },
                        child: Text('Bestätigen')),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 50),
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
                              (route) => false);
                        },
                        child: Text('Abbrechen',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold))),
                  ),
                ],
              )
            ]));
  }
}
