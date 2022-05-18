import 'package:flutter/material.dart';
import 'package:testpersonal/main.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';

class TerminInfoChecker extends StatelessWidget {
  const TerminInfoChecker({ Key? key, required this.terminId }) : super(key: key);

  final String terminId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Probe anlegen'),
        actions: <Widget> [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.help))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Text('Termin ID: ' + '${terminId}', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            ),
          ),

          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(900, 100),
                maximumSize: const Size(900, 100),
                primary: Color.fromARGB(255, 218, 217, 217),
                shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: MyHomePage(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false
                  // )
                );
            }, 
            child: Text('Abbrechen',
            style: TextStyle(
                    color: Colors.black,),)
      ),
          )]
      )
    );
  }
}