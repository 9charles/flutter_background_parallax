import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Background Parallax Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  double _accelerometerValueX = 0;

  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValueX = event.x ;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {

    double offsetZero = _accelerometerValueX < 2 ? (_accelerometerValueX > -2 ? _accelerometerValueX: -2) : 2;
    offsetZero = offsetZero * (-1);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.deepPurple[800],
            child: Container(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/bg-1.png',
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment(0 + (offsetZero/5), 0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/water-drop-1.png',
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment(0 + (offsetZero/30), 0),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/logo-1.png',
              width: MediaQuery.of(context).size.width / 1.2,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

}
