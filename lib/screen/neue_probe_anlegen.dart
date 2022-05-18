import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testpersonal/main.dart';

class NeueProbeAnlegen extends StatefulWidget {
  const NeueProbeAnlegen({Key? key}) : super(key: key);

  @override
  State<NeueProbeAnlegen> createState() => _NeueProbeAnlegenState();
}

class _NeueProbeAnlegenState extends State<NeueProbeAnlegen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Probe anlegen'),
      ),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            final String? code = barcode.rawValue;
            debugPrint('Barcode found! $code');
          }
      ),
    );
  }
}