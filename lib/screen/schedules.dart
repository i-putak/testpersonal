import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../main.dart';
import './retesting.dart';

class ViewSchedule extends StatelessWidget {
  const ViewSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termineinübersicht'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "21.05.2022"), //Textgröße verändern, Abstand zwischen buttons und text, Card verschönern, Liste daraus machen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  )),
                ),
                Card(
                  elevation: 10,
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "10:30-10:45 Uhr"), //Textgröße verändern, Abstand zwischen buttons und text, Card verschönern, Liste daraus machen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  )),
                ),
                Card(
                  elevation: 10,
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "10:45-11:00 Uhr"), //Textgröße verändern, Abstand zwischen buttons und text, Card verschönern, Liste daraus machen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
