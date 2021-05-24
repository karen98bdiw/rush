import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rush/managment/game_managment.dart';
import 'package:rush/utils/colors.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  GameManagment gameManagment;
  int seconds = 60;
  int mSeconds = 1000;
  Timer timer;

  @override
  void initState() {
    gameManagment = Provider.of<GameManagment>(context, listen: false);
    timer = Timer.periodic(
      Duration(milliseconds: 1),
      (v) {
        setState(() {
          mSeconds = mSeconds - 1;
        });
        if (mSeconds == 0) {
          setState(() {
            seconds = seconds - 1;
            if (seconds == 0) {
              timer.cancel();
            } else {
              mSeconds = 1000;
            }
          });
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
      body: SafeArea(
        child: Column(
          children: [
            timerAppBar(),
          ],
        ),
      ),
    );
  }

  Widget timerAppBar() => Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 70,
            color: AppColors.Main_Orange,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      timer.cancel();
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  width: 80,
                  height: 80,
                  child: Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$seconds",
                        style: TextStyle(
                          color: AppColors.Main_Orange,
                          fontSize: 24,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$mSeconds",
                        style: TextStyle(
                          color: AppColors.Main_Orange,
                          fontSize: 15,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
                Container(
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.all(4),
                  child: CircularProgressIndicator(
                    value: seconds > 0 ? 1 - (seconds / 60) : 1,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.Purple_Dark),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
