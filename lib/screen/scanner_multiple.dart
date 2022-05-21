import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';

import './invalid_termin_qr.dart';
import 'qr_generator_screen.dart';

//Probe wird nicht benutzt
class Probe {
  late int index;
  late String neueProbenId;
}

List<String> probenIds = [];

class MultipleScanner extends StatefulWidget {
  MultipleScanner(this.amount, this.type);

  final int amount;
  final String type;

  @override
  State<MultipleScanner> createState() => _MultipleScannerState();
}

class _MultipleScannerState extends State<MultipleScanner> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = '';
    String component = '';
    String codes = '';

    if(widget.type == 'eNAT') {
      title = 'Neue eNAT anlegen';
      component = 'Probe';
      codes = 'Proben-QR-Codes';

    } else if (widget.type == 'Kartusche') {
      title = 'Neue Kartusche erstellen';
      component = 'eNAT';
      codes = 'eNAT-QR-Codes';
    }

    for(int k = 0; k < widget.amount; k++){
      probenIds.add('');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${title}', 
          style: TextStyle(fontSize: 25,),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:50, top: 50),
            child: Text('Scannen Sie bitte die ' + '${codes}' + ':',
            style: TextStyle(color: Colors.white,
            fontSize: 30)),
          ),
          for(int i = 0; i < widget.amount; i++)
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 50, top:10, right: 60),
                  child: Text('${component}' + ' ' + '${(i+1)}' + ': ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                      primary: Color.fromARGB(255, 230, 95, 95),
                      shape : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                  ),
                  child: Text('Löschen',
                  style: TextStyle(
                    fontSize: 25,)),
                  onPressed: () {probeDelete(i, probenIds);},
                ),
                Container(
                  padding: EdgeInsets.only(left:10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                        primary: Colors.lightBlueAccent,
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    child: Text('Scannen',
                    style: TextStyle(
                      fontSize: 25,
                    )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: QrMultiScanner(index: i, type: widget.type),
                          type: PageTransitionType.rightToLeft),
                    );
                    },
                  ),
                ),
                ],)
                
              ],
            ),
          
          Column(children: [
          Container(
            padding: EdgeInsets.only(left:50, right:50, bottom:10),
            child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 90),
                        maximumSize: const Size(700, 90),
                        primary: Colors.lightBlueAccent,
                        shape : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    child: Text('${widget.type}' + ' erstellen',
                    style: TextStyle(
                      fontSize: 30,
                    )),
                    onPressed: () {
                      for(int g = 0; g < widget.amount; g++) {
                        print('${component}' + ' ' + g.toString() + ": " + probenIds[g]);
                      }
                      for(int g = widget.amount-1; g >= 0; g--) {
                        probenIds.remove(probenIds[g]);
                      }

                      //Hier soll man POST schicken und als Repsonse ein eNAT-ID bekommen
                      int neueId = 5;

                      if(widget.type == 'eNAT') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: QrGenerator(id: neueId, type: 'eNAT'),
                            type: PageTransitionType.rightToLeft),
                            (route) => false
                        );
                      } else if (widget.type == 'Kartusche') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: QrGenerator(id: neueId, type: 'Kartusche'),
                            type: PageTransitionType.rightToLeft),
                            (route) => false
                        );
                      }
                    },
                  ),
          ),

          Container(
            padding: EdgeInsets.only(left:50, right:50, bottom: 50),
            child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(700, 90),
                      maximumSize: const Size(700, 90),
                      primary: Color.fromARGB(255, 228, 227, 227),
                      shape : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: Text('Abbrechen',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black
                    )
                    ),
                    onPressed: () {
                      for(int g = widget.amount-1; g >= 0; g--) {
                        probenIds.remove(probenIds[g]);
                      }
                      
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          child: MyHomePage(),
                          type: PageTransitionType.leftToRight),
                          (route) => false
                    );
                    },
                  ),
          ),],)
        ],
      )
    );
  }

  void probeDelete(index, probenIds){
    probenIds[index] = '';
  }
}







class QrMultiScanner extends StatefulWidget {
  QrMultiScanner({Key? key, required this.index, required this.type}) : super(key: key);

  int index;
  String type;

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

  @override
  Widget build(BuildContext context) {
    String title = '';
    String component = '';
    String code = '';

    if(widget.type == 'eNAT') {
      title = 'Neue eNAT anlegen';
      component = 'Probe';
      code = 'Proben-QR-Code';

    } else if (widget.type == 'Kartusche') {
      title = 'Neue Kartusche erstellen';
      component = 'eNAT';
      code = 'eNAT-QR-Code';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${title}', 
          style: TextStyle(fontSize: 25,),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40.0, left: 20, bottom: 40),
            child: Text('Scannen Sie bitte den ' + '${code}' + ':',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              )
            ),
          ),
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scannen Sie bitte den QR-Code:'),
              
                ],
              ),
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
        if(result != null && result!.code != null) {
          controller.pauseCamera();
          //globale var, für später
          probenIds[widget.index] = result!.code.toString();
          

          //text Zeigen
          Probe probe = Probe();
          probe.index = widget.index;
          probe.neueProbenId = result!.code.toString();


          Navigator.pop(context);
        } else {
          controller.pauseCamera();
          Navigator.push(
                context,
                PageTransition(
                    child: InvalidTerminQr(),
                    type: PageTransitionType.rightToLeft),
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