import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rush/pages/play_screen.dart';
import 'package:rush/utils/colors.dart';

class GameStartOnboard extends StatefulWidget {
  @override
  _GameStartOnboardState createState() => _GameStartOnboardState();
}

class _GameStartOnboardState extends State<GameStartOnboard> {
  int selectedIndex = 5;

  Timer timer;
  double left = 200;
  double right;
  double top;
  double bottom = 0;

  bool v = false;

  var al = Alignment.center;
  var p = EdgeInsets.all(0);

  List<Color> animColors = [
    AppColors.Pink_Light,
    AppColors.Green_Dark,
    AppColors.Main_Orange,
    AppColors.Blue_Dark,
    AppColors.Purple_Dark,
    AppColors.Red_Dark,
  ];

  decrement() {
    if (selectedIndex > 1) {
      setState(() {
        selectedIndex = selectedIndex - 1;
      });
    }
  }

  @override
  void initState() {
    selectedIndex = 5;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (d) {
        decrement();
        setState(() {
          if (selectedIndex == 4) {
            v = true;
            bottom = MediaQuery.of(context).size.height / 2 - 30;
          }
        });
        if (selectedIndex == 3) {
          v = true;
          left = MediaQuery.of(context).size.width / 2 - 30;
        }
        if (selectedIndex == 2) {
          v = true;
          bottom = MediaQuery.of(context).size.height / 2 - 30;
        }

        if (selectedIndex == 1) {
          v = true;
          left = MediaQuery.of(context).size.width / 2 - 30;
          timer.cancel();
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            duration: Duration(seconds: 1),
            color: animColors[selectedIndex],
            curve: Curves.decelerate,
          ),
          AnimatedPositioned(
            onEnd: () {
              if (selectedIndex == 4) {
                setState(() {
                  v = false;
                  left = 0;
                });
              }
              if (selectedIndex == 3) {
                setState(() {
                  v = false;
                  bottom = MediaQuery.of(context).size.height - 60;
                });
              }
              if (selectedIndex == 2) {
                setState(() {
                  v = false;
                  bottom = MediaQuery.of(context).size.height / 2 - 60;
                  left = MediaQuery.of(context).size.width - 60;
                });
              }
              if (selectedIndex == 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (c) => PlayScreen(),
                  ),
                );
              }
            },
            top: top,
            bottom: bottom,
            left: left,
            child: Visibility(
              visible: v,
              child: Text(
                "$selectedIndex",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
            duration: Duration(
              milliseconds: 500,
            ),
          ),
        ],
      ),
    );
  }
}

// Stack(
//         alignment: Alignment.center,
//         children: [
//           AnimatedContainer(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             duration: Duration(seconds: 1),
//             color: animColors[selectedIndex],
//             curve: Curves.decelerate,
//           ),

//         ],
//       ),
