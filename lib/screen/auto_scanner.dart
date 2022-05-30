import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';
import 'package:http/http.dart' as http;

import './invalid_termin_qr.dart';
import 'qr_generator_screen.dart';
import '../widget/pop_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Probe wird nicht benutzt
class Probe {
  late int index;
  late String neueProbenId;
}

List<String> _probenIds = [];
List<Color> _buttonColors = [];

int zaehler = 0;

Future<int> _createEnattest(int probenId1, int probenId2, int probenId3,
    int probenId4, int probenId5) async {
  var url = "http://10.0.2.2:8080/api/createEnattest/" +
      probenId1.toString() +
      "/" +
      probenId2.toString() +
      "/" +
      probenId3.toString() +
      "/" +
      probenId4.toString() +
      "/" +
      probenId5.toString() +
      "/";

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    print('Enattest wurde erstellt');

    print(response.body);

    Map data = json.decode(response.body);

    print(data);

    int enattestId = data['enatId'];
    print(enattestId);
    return enattestId;
  } else {
    throw Exception('Enattest konnte nicht angelegt werden');
  }
}

Future<int> _createPooltest(
    int enattestId1, int enattestId2, int enattestId3) async {
  var url = "http://10.0.2.2:8080/api/createPooltest/" +
      enattestId1.toString() +
      "/" +
      enattestId2.toString() +
      "/" +
      enattestId3.toString();

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    print('Pooltest wurde erstellt');
    print(response.body);

    Map data = json.decode(response.body);

    print(data);

    int pooltestId = data['pooltestId'];
    return pooltestId;
  } else {
    throw Exception('Pooltest konnte nicht angelegt werden');
  }
}

class QrMultiScanner extends StatefulWidget {
  QrMultiScanner({Key? key, required this.type, required this.amount})
      : super(key: key);

  String type;
  int amount;

  @override
  State<StatefulWidget> createState() => _QrMultiScannerState();
}

class _QrMultiScannerState extends State<QrMultiScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void probeDelete(index, probenIds) {
    probenIds[index] = '';
    _buttonColors[index] = Color.fromARGB(255, 74, 74, 74);
  }

  @override
  Widget build(BuildContext context) {
    if (_probenIds.isEmpty) {
      print('ProbenIds is empty');
      for (int k = 0; k < widget.amount; k++) {
        _probenIds.add('');
        _buttonColors.add(Color.fromARGB(255, 74, 74, 74));
      }
    }

    String title = '';
    String component = '';
    String code = '';

    if (widget.type == 'eNAT') {
      title = 'Neue eNAT anlegen';
      component = 'Proben';
      code = 'Proben-QR-Codes';
    } else if (widget.type == 'Kartusche') {
      title = 'Neue Kartusche erstellen';
      component = 'eNAT';
      code = 'eNAT-QR-Codes';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          '${title}',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40.0, left: 20, bottom: 20),
            child: RichText(
                text: TextSpan(
                    // style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Scannen Sie bitte die ',
                      style: TextStyle(
                        fontSize: 25,
                      )),
                  TextSpan(
                      text: '${code}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color.fromARGB(255, 128, 214, 255))),
                  TextSpan(text: '.', style: TextStyle(fontSize: 20)),
                ])
                /*,'Scannen Sie bitte die ' + '${code}' + ':',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                )*/
                ),
          ),
          Expanded(flex: 9, child: _buildQrView(context)),
          const Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
            ),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                  'Um einen QR-Code erneut zu scannen,  \n klicken Sie auf den jeweiligen Button.',
                  style: TextStyle(fontSize: 25))),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                children: [
                  for (int i = 0; i < widget.amount; i++)
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          maximumSize: Size(200, 50),
                          primary: _buttonColors[i],
                          shadowColor: Theme.of(context).primaryColor,
                        ),
                        child: Text('${component}-ID: ' + '${_probenIds[i]}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            )),
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => pop_up(
                                  context, 'K', 'eNAT', widget.amount, zaehler),
                            );
                            probeDelete(i, _probenIds);
                            zaehler = i;
                            controller?.resumeCamera();
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(700, 70),
                maximumSize: Size(700, 70),
                shadowColor: Theme.of(context).accentColor,
              ),
              child: Text('Kartusche erstellen',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 128, 214, 255),
                  )),
              onPressed: () {
                zaehler = 0;

                if (widget.type == 'eNAT') {
                  _createEnattest(
                          int.parse(_probenIds[0]),
                          int.parse(_probenIds[1]),
                          int.parse(_probenIds[2]),
                          int.parse(_probenIds[3]),
                          int.parse(_probenIds[4]))
                      .then((enattestId) {
                    for (int g = widget.amount - 1; g >= 0; g--) {
                      _probenIds.remove(_probenIds[g]);
                      _buttonColors.remove(_buttonColors[g]);
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: QrGenerator(id: enattestId, type: 'eNAT'),
                            type: PageTransitionType.rightToLeft),
                        (route) => false);
                  });
                } else if (widget.type == 'Kartusche') {
                  _createPooltest(int.parse(_probenIds[0]),
                          int.parse(_probenIds[1]), int.parse(_probenIds[2]))
                      .then((pooltestId) {
                    for (int g = widget.amount - 1; g >= 0; g--) {
                      _probenIds.remove(_probenIds[g]);
                      _buttonColors.remove(_buttonColors[g]);
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child:
                                QrGenerator(id: pooltestId, type: 'Kartusche'),
                            type: PageTransitionType.rightToLeft),
                        (route) => false);
                  });
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(700, 70),
                  maximumSize: Size(700, 70),
                  shadowColor: Theme.of(context).accentColor,
                  side: BorderSide(
                    width: 3.0,
                    color: Colors.white,
                  )),
              child: Text('Abbrechen',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                for (int g = widget.amount - 1; g >= 0; g--) {
                  _probenIds.remove(_probenIds[g]);
                  _buttonColors.remove(_buttonColors[g]);
                }

                zaehler = 0;

                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: MyHomePage(),
                        type: PageTransitionType.leftToRight),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var qrType = result!.code.toString().split('_');
        if (result != null && result!.code != null) {
          //globale var, für später
          controller.pauseCamera();

          if (widget.type == 'eNAT') {
            if (qrType[0] == 'P') {
              _probenIds[zaehler] = qrType[1].toString();
              _buttonColors[zaehler] = Color.fromARGB(255, 128, 214, 255);

              sleep(const Duration(seconds: 3));
              zaehler++;

              controller.resumeCamera();
            } else if (qrType[0] == 'K') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'K', 'Probe', widget.amount, zaehler),
              );
            } else if (qrType[0] == 'E') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'E', 'Probe', widget.amount, zaehler),
              );
            } else if (qrType[0] == 'T') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'T', 'Probe', widget.amount, zaehler),
              );
            }
          } else if (widget.type == 'Kartusche') {
            if (qrType[0] == 'E') {
              controller.pauseCamera();
              _probenIds[zaehler] = qrType[1].toString();
              _buttonColors[zaehler] = Color.fromARGB(255, 128, 214, 255);

              sleep(const Duration(seconds: 5));
              zaehler++;
              controller.resumeCamera();
            } else if (qrType[0] == 'K') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'K', 'eNAT', widget.amount, zaehler),
              );
            } else if (qrType[0] == 'P') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'P', 'eNAT', widget.amount, zaehler),
              );
            } else if (qrType[0] == 'T') {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    pop_up(context, 'T', 'eNAT', widget.amount, zaehler),
              );
            }
          }
        } else {
          controller.pauseCamera();
          Navigator.push(
            context,
            PageTransition(
                child: InvalidTerminQr(), type: PageTransitionType.rightToLeft),
          );
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
