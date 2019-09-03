import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game/src/spinningwheel.dart';

import 'main.dart';

class MyGamePage extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  dispose() {
    _dividerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
//        Color(0xffDDC3FF),
        elevation: 0.0,
        title: Text(
          "Тоглоом тоглох",
          style: TextStyle(color: Colors.red, fontSize: 15.0),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.red),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp()));
            }),
      ),
//      backgroundColor: Color(0xffDDC3FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Азаа үзээрэй",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SpinningWheel(
              Image.asset('images/wheel.png'),
              width: 330,
              height: 330,
              initialSpinAngle: 0.0,
//                _generateRandomAngle(),
              canInteractWhileSpinning: false,
              dividers: 10,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('images/roulette-center-300.png'),
              secondaryImageHeight: 70,
              secondaryImageWidth: 70,
            ),
            SizedBox(height: 30),
            StreamBuilder(
                stream: _dividerController.stream,
                builder: (context, snapshot) {
                  print(snapshot.data);
                  print(snapshot.hasData ? snapshot.data : "no data in wheel");
                  return snapshot.hasData
                      ? RouletteScore(snapshot.data)
                      : Container();
                })
          ],
        ),
      ),
    );
  }

//  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
//  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '1 оноо',
    2: 'Урмын үгс',
    3: '2 оноо',
    4: 'Урмын үгс',
    5: '3 оноо',
    6: 'Урмын үгс',
    7: '4 оноо',
    8: 'Хүрд дахин эргүүлэх',
    9: '5 оноо',
    10: 'Баярлалаа',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 24.0,
            color: Colors.red[400]));
  }
}
