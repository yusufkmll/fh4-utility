import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'globals.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Globals.fh4GradColorA,
                Globals.fh4GradColorB
              ]
            )
          ),
        ),
        title: const Text(
          "FORZA HORIZON 4",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Artegra'
          ),
        ),
      ),
      body: Center(
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 8,
              axisLabelStyle: GaugeTextStyle(
                color: Colors.white,
              ),
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 6, color: Colors.white),
                GaugeRange(startValue: 6, endValue: 8, color: Colors.red),
              ],
              annotations: const <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text(
                    "87",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


