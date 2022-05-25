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

List<String> _probenIds = [];


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

    if(_probenIds.isEmpty) {
      print('ProbenIds is empty');
      for(int k = 0; k < widget.amount; k++){
      _probenIds.add('');
      } 
    }

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

    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 50, top:10, right: 60),
                  child: Text('${component}' + ' ' + '${(i+1)}' + ': ' + '${_probenIds[i]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),),
                ),
                Container(
                  padding: EdgeInsets.only(right: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200,50),
                      maximumSize: Size(200,50),
                      primary: Theme.of(context).colorScheme.secondary,
                      shadowColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text('Löschen',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    )),
                    onPressed: () {
                    setState(() {
                      probeDelete(i, _probenIds);
                    });},
                  ),
                  Container(
                    padding: EdgeInsets.only(left:10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      minimumSize: Size(200,50),
                      maximumSize: Size(200,50)
                    ),
                      child: Text('Scannen',
                      style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: QrMultiScanner(index: i, type: widget.type, amount: widget.amount),
                            type: PageTransitionType.rightToLeft),
                      );
                      },
                    ),
                  ),
                  ],),
                )
                
              ],
            ),
          
          Column(children: [
          Container(
            padding: EdgeInsets.only(left:50, right:50, bottom:10),
            child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(700,90),
                        maximumSize: Size(700,90)
                     ),
                    child: Text('${widget.type}' + ' erstellen',),
                    onPressed: () {
                      for(int g = 0; g < widget.amount; g++) {
                        print('${component}' + ' ' + g.toString() + ": " +  _probenIds[g]);
                      }
                      for(int g = widget.amount-1; g >= 0; g--) {
                        _probenIds.remove(_probenIds[g]);
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
                     primary: Color.fromARGB(255, 228, 227, 227), 
                      minimumSize: Size(700,90),
                      maximumSize: Size(700,90)
                    ),
                    child: Text('Abbrechen',
                    style: TextStyle(
                      color: Colors.black
                    )
                    ),
                    onPressed: () {
                      for(int g = widget.amount-1; g >= 0; g--) {
                        _probenIds.remove(_probenIds[g]);
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
  QrMultiScanner({Key? key, required this.index, required this.type, required this.amount}) : super(key: key);

  int index;
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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${title}', 
          style: TextStyle(fontSize: 25,),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40.0, left: 20, bottom: 40),
            child: Text('Scannen Sie bitte den ' + '${code}' + ':',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              )
            ),
          ),
          Expanded(flex: 4, child: _buildQrView(context)),
          const Expanded(
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
        var qrType = result.toString().split('_');
        if(result != null && result!.code != null) {
          //globale var, für später

          if(widget.type == 'eNAT'){
            if(qrType[0] == 'P'){
              controller.pauseCamera();
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'K'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'E'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'T'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }
          }else if(widget.type == 'Kartusche'){
            if(qrType[0] == 'E'){
              controller.pauseCamera();
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'K'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'P'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }else if(qrType[0] == 'T'){
              _probenIds[widget.index] = result!.code.toString();

              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MultipleScanner(widget.amount, widget.type),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
              );
            }
          }
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