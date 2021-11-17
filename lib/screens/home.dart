import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fh4_utility_tools/globals.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
            fontFamily: 'Artegra',
          ),
        ),
      ),
      body: Center(
        child: Text(
          "hello",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Artegra',
            color: Colors.white,
          ),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar),
              label: "Gauge"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monitor),
              label: "Telemetry"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airport_shuttle),
              label: "H-Shifter"
          ),
        ],
      ),
    );
  }
}