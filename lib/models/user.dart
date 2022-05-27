import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';

class User {
  late final int _userId;
  late final String _name;
  late final String _vorname;
  late final DateTime _geburtsdatum;
  late final String _email;
  late final String _telefonnummer;
  late final String _klasse;

  User(this._userId, this._name, this._vorname, this._geburtsdatum, this._email,
      this._telefonnummer, this._klasse);

  String get klasse => _klasse;

  String get telefonnummer => _telefonnummer;

  String get email => _email;

  DateTime get geburtsdatum => _geburtsdatum;

  String get vorname => _vorname;

  String get name => _name;

  int get userId => _userId;
}

Future<User> getUserDetails(int teilnehmerId) async {
  var url = "http://10.0.2.2:8080/api/getUser/" + teilnehmerId.toString();

  http.Response response =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

  Map userData = json.decode(response.body);
  print(userData);

  User loadedUser = User(
      userData['teilnehmerId'],
      userData['nachname'],
      userData['vorname'],
      DateTime.parse(userData['geburtsdatum']),
      userData['email'],
      userData['telefonnummer'],
      userData['klasse']);

  return loadedUser;
}
