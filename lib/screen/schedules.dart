import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import './retesting.dart';
import 'package:http/http.dart' as http;

List<LoadedTerminslot> loadedTerminslots = [];

Future<void> _getAlleTermine() async {
  loadedTerminslots = [];
  var url = "http://10.0.2.2:8080/api/getAlleTermine/";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    print('Termine wurden abgerufen');

    List<dynamic> data = json.decode(response.body);

    print(data);

    for (int i = 0; i < data.length; i++) {
      loadedTerminslots.add(LoadedTerminslot(
          DateFormat('dd.MM.yyyy').format(DateTime.parse(data[i]['datum'])),
          DateFormat('HH:mm').format(DateTime.parse(data[i]['datum'])),
          data[i]['anzahlGebuchtePlaetze']));
      print('Durchlauf Nr:'+i.toString());
    }
    print(loadedTerminslots);
  } else {
    throw Exception('Termine konnten nicht abgerufen werden');
  }
}

class LoadedTerminslot {
  late final String _datum;
  late final String _zeitslot;
  late final int _anzahl;

  LoadedTerminslot(this._datum, this._zeitslot, this._anzahl);

  int get anzahl => _anzahl;

  set anzahl(int value) {
    _anzahl = value;
  }

  String get zeitslot => _zeitslot;

  set zeitslot(String value) {
    _zeitslot = value;
  }

  String get datum => _datum;

  set datum(String value) {
    _datum = value;
  }
}

class ViewSchedule extends StatelessWidget {
  const ViewSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Terminübersicht', style: TextStyle(fontSize: 25)),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 100, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 80),
                        child: Text(
                          'Terminslot',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )),
                    Container(
                        padding: EdgeInsets.only(right: 80),
                        child: Text('Anzahl der \ngebuchten Plätze',
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.right)),
                  ],
                ),
              ),
              FutureBuilder(
                future: _getAlleTermine(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print('builded');
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: loadedTerminslots.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(loadedTerminslots[index].datum,style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),),
                            Text(loadedTerminslots[index].zeitslot,style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),),
                            Text(loadedTerminslots[index].anzahl.toString(),style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),),
                          ],


                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: 50, top: 200),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(700, 90),
                    maximumSize: Size(700, 90),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: MyHomePage(),
                            type: PageTransitionType.rightToLeft),
                        (route) => false);
                  },
                  child: Text('Zum Startbildschirm'),
                ),
              )
            ],
          ),
        ));
  }
}
