import 'dart:developer';

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
          enableLoadingAnimation: true,
          animationDuration: 5000,
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 220,
              labelOffset: 25,
              pointers: <GaugePointer>[
                NeedlePointer(
                  enableAnimation: true,
                  animationType: AnimationType.easeOutBack,
                  value: 50,
                  needleLength: 0.7,
                  needleColor: Colors.red[900],
                  knobStyle: KnobStyle(color: Colors.black, borderWidth: 0.02, borderColor: Colors.white),
                  enableDragging: true,
                  tailStyle: TailStyle(color: Colors.lightBlue),
                )
              ],
              axisLabelStyle: GaugeTextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 180, color: Colors.white),
                GaugeRange(startValue: 180, endValue: 220, color: Colors.red),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "87\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: "NeonDigital"
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'km/h', style: TextStyle(fontSize: 15, fontFamily: "Artegra")),
                      ]
                    )
                  ),
                  angle: 90,
                  positionFactor: 0.5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


/*
Text(
                    "87",
                    style: TextStyle(
                      fontSize: 100,
                      fontFamily: "NeonDigital",
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                    ),
                  ),
 */