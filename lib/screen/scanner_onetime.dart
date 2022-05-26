import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/screen/ergebnis_eingeben.dart';
import 'package:testpersonal/widget/pop_up.dart';
import 'package:http/http.dart' as http;

import './termin_info_checker_screen.dart';
import './invalid_termin_qr.dart';
import '../models/appointment.dart';
import '../models/user.dart';

Future<int> _createProbe(int terminId) async {
  var uri =
      Uri.http('10.0.2.2:8080', '/api/createProbe/' + terminId.toString());

  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    print('Probe wurde erstellt');

    Map data = json.decode(response.body);

    int probenId = data['probe_id'];
    return probenId;
  } else {
    throw Exception('Probe konnte nicht angelegt werden');
  }
}

class QRViewExample extends StatefulWidget {
  QRViewExample({Key? key, required this.type}) : super(key: key);

  String type;

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
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

  @override
  Widget build(BuildContext context) {
    String title = '';
    String text = '';

    if (widget.type == 'Probe') {
      title = 'Neue Probe anlegen';
      text = 'Scannen Sie bitte den Termin-QR-Code';
    } else if (widget.type == 'Kartusche') {
      title = 'Ergebnis eingeben';
      text = 'Scannen Sie bitte den Kartuschen- oder Retest-QR-Code';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40.0, left: 20, bottom: 40),
            child: Text('${text}',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                )),
          ),
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
            ),
          )
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
          controller.pauseCamera();
          if (widget.type == 'Probe') {
            if (qrType[0] == 'T') {
              collectAppointmentDetails(int.parse(qrType[1])).then(
                (loadedAppointment) =>
                    getUserDetails(loadedAppointment.userId).then(
                  (loadedUser) => {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: TerminInfoChecker(
                              user: loadedUser,
                              appointment: loadedAppointment,
                            ),
                            type: PageTransitionType.rightToLeft),
                        (route) => false)
                  },
                ),
              );
            } else if (qrType[0] == 'K') {
              pop_up(context, 'K', 'Probe', 1, 1);
            } else if (qrType[0] == 'E') {
              pop_up(context, 'E', 'Probe', 1, 1);
            } else if (qrType[0] == 'P') {
              pop_up(context, 'P', 'Probe', 1, 1);
            }
          } else if (widget.type == 'Kartusche') {
            if (qrType[0] == 'K') {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: ErgebnisAuswaehlen(),
                      type: PageTransitionType.rightToLeft),
                  (route) => false);
            } else if (qrType[0] == 'P') {
              pop_up(context, 'P', 'Kartusche', 1, 1);
            } else if (qrType[0] == 'E') {
              pop_up(context, 'E', 'Kartusche', 1, 1);
            } else if (qrType[0] == 'T') {
              pop_up(context, 'T', 'Kartusche', 1, 1);
            }
          } 
        } else {
          controller.pauseCamera();
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: InvalidTerminQr(),
                  type: PageTransitionType.rightToLeft),
              (route) => false);
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
