import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import './retesting.dart';

class ViewSchedule extends StatelessWidget {
  const ViewSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Termineinübersicht', style: TextStyle(fontSize: 25)),
        ),
        body: Column(
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
            for (int i = 10; i < 17; i++)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: EdgeInsets.only(left: 80),
                  child: Text('${i}' + ':00 - ' + '${i}' + ':30',
                      style: TextStyle(fontSize: 23)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 80),
                  child: Text('15', style: TextStyle(fontSize: 23)),
                ),
              ]),
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
        ));
  }
}
