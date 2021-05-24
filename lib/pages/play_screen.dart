import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rush/blocs/game_bloc.dart';
import 'package:rush/blocs/game_event.dart';
import 'package:rush/blocs/game_state.dart';
import 'package:rush/managment/game_managment.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/diologs.dart';

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
  GameBloc gameBloc;

  @override
  void initState() {
    gameBloc = BlocProvider.of<GameBloc>(context, listen: false);
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
    return BlocConsumer<GameBloc, GameState>(
      listener: (c, s) {},
      builder: (c, state) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              timerAppBar(),
              SizedBox(
                height: 30,
              ),
              state.runtimeType == GameLoaded
                  ? questionIndexIndicator(state)
                  : Container(),
              Text(
                  "${gameManagment.curentGame.questions[(state as GameLoaded).curentQuestionIndex].questionText}"),
              if (gameManagment
                      .curentGame
                      .questions[(state as GameLoaded).curentQuestionIndex]
                      .image !=
                  null)
                Image.network(
                  gameManagment
                      .curentGame
                      .questions[(state as GameLoaded).curentQuestionIndex]
                      .image,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ...gameManagment.curentGame
                  .questions[(state as GameLoaded).curentQuestionIndex].options
                  .map(
                    (e) => Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        onPressed: () {
                          var nextIndex =
                              (state as GameLoaded).curentQuestionIndex + 1;
                          if (nextIndex !=
                              gameManagment.curentGame.questions.length) {
                            gameBloc.add(SetIndex(nextIndex));
                          } else {
                            showError(errorText: "Game is over");
                          }
                        },
                        child: Text(e),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
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

  Widget questionIndexIndicator(GameLoaded state) => Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) => GestureDetector(
            onTap: () {
              gameBloc.add(SetIndex(i));
            },
            child: Container(
              width: (MediaQuery.of(context).size.width -
                      (gameManagment.curentGame.questions.length - 1) * 10 -
                      20) /
                  gameManagment.curentGame.questions.length,
              height: 20,
              color:
                  state.curentQuestionIndex == i ? Colors.green : Colors.grey,
            ),
          ),
          separatorBuilder: (c, i) => SizedBox(
            width: 10,
          ),
          itemCount: gameManagment.curentGame.questions.length,
        ),
      );
}
