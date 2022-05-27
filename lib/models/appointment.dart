import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './user.dart';

class AppointmentDetails {
  late final int _appointmentId;
  late final int _timeslotId;
  late final int _userId;
  late final DateTime _datum;

  AppointmentDetails(
      this._appointmentId, this._timeslotId, this._userId, this._datum);

  DateTime get datum => _datum;

  int get userId => _userId;

  int get timeslotId => _timeslotId;

  int get appointmentId => _appointmentId;
}

Future<AppointmentDetails> _getAppointmentDetails(int terminId) async {
  var url = "http://10.0.2.2:8080/api/getEinzeltermin/" + terminId.toString();

  http.Response response =
      await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

  Map appointmentData = json.decode(response.body);

  if (response.statusCode == 200) {
    var url = "http://10.0.2.2:8080/api/getTerminslot/" +
        appointmentData['terminslotId'].toString();

    http.Response response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      Map timeslotData = json.decode(response.body);

      AppointmentDetails loadedAppointment = AppointmentDetails(
        terminId,
        appointmentData['terminslotId'],
        appointmentData['teilnehmerId'],
        DateTime.parse(timeslotData['datum']),
      );
      return loadedAppointment;
    }else{
      throw Exception("Terminslot konnte nicht geladen werden!");
    }
  } else {
    throw Exception("Einzeltermin konnte nicht geladen werden!");
  }
}


Future<AppointmentDetails> collectAppointmentDetails(int terminId) async {

  return await _getAppointmentDetails(terminId);
}
