import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import './retesting.dart';


class ErgebnisAuswaehlen extends StatefulWidget {
  const ErgebnisAuswaehlen({Key? key}) : super(key: key);

  @override
  State<ErgebnisAuswaehlen> createState() => _ErgebnisAuswaehlenState();
}

class _ErgebnisAuswaehlenState extends State<ErgebnisAuswaehlen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50),
              child: Text("Geben Sie bitte das Testergebnis der Kartusche 1234 ein:",
                  style: TextStyle(fontSize: 25),),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 150, 150, 150),
                shadowColor: Color.fromARGB(255, 39, 39, 39),
              ),
             onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const ErgebnisUngueltig(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Ungültig'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                shadowColor: Color.fromARGB(255, 39, 39, 39),
              ),
               onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const ErgebnisPositiv(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Positiv'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shadowColor: Color.fromARGB(255, 39, 39, 39),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const ErgebnisNegativ(),
                      type: PageTransitionType.rightToLeft),
                      (route) => false,
                  // )
                );
              },
              child: const Text('Negativ'),
            ),
          ],
        ),
      )
    );
  }
}

class ErgebnisUngueltig extends StatefulWidget {
  const ErgebnisUngueltig({Key? key}) : super(key: key);

  @override
  State<ErgebnisUngueltig> createState() => _ErgebnisUngueltigState();
}

class _ErgebnisUngueltigState extends State<ErgebnisUngueltig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                  child: RichText(
                      text: const TextSpan(
                          text: 'Bestätigen Sie bitte, dass das Ergebnis der Kartusche ',
                          style: TextStyle(
                              fontSize: 25
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'UNGÜLTIG',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            TextSpan(
                                text: ' ist:',
                                style: TextStyle(
                                    fontSize: 25
                                )
                            )
                          ]
                      )

                  )
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: RetestNow(),
                        type: PageTransitionType.rightToLeft),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Bestätigen'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Color.fromARGB(255, 228, 227, 227),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: const ErgebnisAuswaehlen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Zurück'),
              ),
            ],
          ),
        )
    );
  }
}

class ErgebnisPositiv extends StatefulWidget {
  const ErgebnisPositiv({Key? key}) : super(key: key);

  @override
  State<ErgebnisPositiv> createState() => _ErgebnisPositivState();
}

class _ErgebnisPositivState extends State<ErgebnisPositiv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                  child: RichText(
                      text: const TextSpan(
                          text: 'Bestätigen Sie bitte, dass das Ergebnis der Kartusche ',
                          style: TextStyle(
                              fontSize: 25
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'POSITIV',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 202, 67, 57),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                )
                            ),
                            TextSpan(
                                text: ' ist:',
                                style: TextStyle(
                                    fontSize: 25
                                )
                            )
                          ]
                      )
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: 90),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: RetestNow(),
                          type: PageTransitionType.rightToLeft),
                          (route) => false,
                      // )
                    );
                  },
                  child: const Text('Bestätigen'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black,
                   primary: Color.fromARGB(255, 228, 227, 227),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const ErgebnisAuswaehlen(),
                          type: PageTransitionType.leftToRight),
                          (route) => false,
                      // )
                    );
                  },
                  child: const Text('Zurück'),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class ErgebnisNegativ extends StatefulWidget {
  const ErgebnisNegativ({Key? key}) : super(key: key);

  @override
  State<ErgebnisNegativ> createState() => _ErgebnisNegativState();
}

class _ErgebnisNegativState extends State<ErgebnisNegativ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                child: RichText(
                  text: const TextSpan(
                      text: 'Bestätigen Sie bitte, dass das Ergebnis der Kartusche ',
                      style: TextStyle(
                        fontSize: 25
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'NEGATIV',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                          )
                        ),
                        TextSpan(
                          text: ' ist:',
                          style: TextStyle(
                            fontSize: 25
                          )
                        )
                      ]
                  )

                )
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: const NegativeAnzeigen(),
                        type: PageTransitionType.rightToLeft),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Bestätigen'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Color.fromARGB(255, 228, 227, 227),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: const ErgebnisAuswaehlen(),
                        type: PageTransitionType.leftToRight),
                        (route) => false,
                    // )
                  );
                },
                child: const Text('Zurück'),
              ),
            ],
          ),
        )
    );
  }
}

class NegativeAnzeigen extends StatefulWidget {
  const NegativeAnzeigen({Key? key}) : super(key: key);

  @override
  State<NegativeAnzeigen> createState() => _NegativeAnzeigenState();
}

class _NegativeAnzeigenState extends State<NegativeAnzeigen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                  padding: EdgeInsets.only(left:50, top: 50, right:50),
                  child: Text(
                      "eNATs, die mit diesem Pooltest NEGATIV getestet wurden:",
                      style: TextStyle(fontSize: 25)
                  )
                ),
              Container(
                padding: EdgeInsets.only(left:100, top: 50),
                child: Text("eNAT-ID:  1234\n\neNAT-ID:  2345\n\neNAT-ID:  3456",
                    style: TextStyle(fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
                    ),
              ),
              Container(
                padding: EdgeInsets.only(left: 50, top: 70),
                child: Text("Dies eNATs dürfen Sie jetzt entsorgen.",
                    style: TextStyle(fontSize: 25)),
              ),]),
              Container(
                padding:EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: const MyHomePage(),
                          type: PageTransitionType.rightToLeft),
                          (route) => false,
                      // )
                    );
                  },
                  child: const Text('Bestätigen'),
                ),
              ),
            ],
          ),
        )
    );
  }
}


class RetestNow extends StatelessWidget {
  const RetestNow({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Ergebnis eingeben',style: TextStyle(fontSize: 25)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Container(
            padding: EdgeInsets.all(50),
            child:Text('Diese eNATs wurden als POSITIV gekennzeichnet. Möchten Sie sie sofort erneut testen?',
            style: TextStyle(fontSize: 25))),
          Column(
            children: [
            Container(
              padding: EdgeInsets.only(top: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                      
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: Retesting(),
                        type: PageTransitionType.rightToLeft),
                        (route) => false,
                        // )
                      );
                    },
                    child: const Text('Jetzt erneut testen'),
                  ),
            ),

                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: Color.fromARGB(255, 228, 227, 227),
                    ),
                    onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: MyHomePage(),
                              type: PageTransitionType.rightToLeft),
                              (route) => false,
                              // )
                        );
                    },
                    child: const Text('Später'),
                  ),
                ),
          ],)
        ],)
      
    ));
  }
}
