import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Kartusche {
  late final int _kartuschenId;
  late final int _enat1Id;
  late final int _enat2Id;
  late final int _enat3Id;
  late final String _ergebnis;

  Kartusche(this._kartuschenId, this._enat1Id, this._enat2Id, this._enat3Id,
      this._ergebnis);

  String get ergebnis => _ergebnis;

  int get enat3Id => _enat3Id;

  int get enat2Id => _enat2Id;

  int get enat1Id => _enat1Id;

  int get kartuschenId => _kartuschenId;
}

Future<Kartusche> loadKartusche(int kartuschenId) async {
  var uri =
      Uri.http('10.0.2.2:8080', '/api/getPooltest/' + kartuschenId.toString());
  http.Response response = await http.get(
    uri,
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    print('Kartusche gefunden!');

    Map data = json.decode(response.body);
    print(data);

    Kartusche loadedKartusche = Kartusche(
        data['pooltestId'],
        data['enattestId1'],
        data['enattestId2'],
        data['enattestId3'],
        data['ergebnis'].toString());
    return loadedKartusche;
  } else {
    throw Exception("Kartusche nicht gefunden!");
  }
}

Future<void> setPooltestResult(int kartuschenId, String ergebnis) async {
  var uri = Uri.http('10.0.2.2:8080',
      '/api/setPooltestErgebnis/' + kartuschenId.toString() + '/' + ergebnis);
  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    print('Kartuschen ergebnis gesetzt!');
  } else {
    throw Exception("Kartusche nicht gefunden!");
  }
}

Future<void> addRetest(Kartusche kartusche) async {
  if (kartusche.enat1Id != null) {
    var uri = Uri.http('10.0.2.2:8080',
        '/api/createRetest/' + kartusche.enat1Id.toString());
    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print('EnatId1 zu Retest hinzugefügt!');
    } else {
      throw Exception("EnatId1 nicht gefunden!");
    }
  }
  if (kartusche.enat2Id != null) {
    var uri = Uri.http('10.0.2.2:8080',
        '/api/createRetest/' + kartusche.enat2Id.toString());
    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print('EnatId2 zu Retest hinzugefügt!');
    } else {
      throw Exception("EnatId2 nicht gefunden!");
    }
  }

  if (kartusche.enat3Id != null) {
    var uri = Uri.http('10.0.2.2:8080',
        '/api/createRetest/' + kartusche.enat3Id.toString());
    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print('EnatId3 zu Retest hinzugefügt!');
    } else {
      throw Exception("EnatId3 nicht gefunden!");
    }
  }
}
