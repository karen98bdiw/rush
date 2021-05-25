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
    gameManagment.clearAnswers();
    gameBloc.add(SetIndex(0));
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
              questionView(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionView(state) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${gameManagment.curentGame.questions[(state as GameLoaded).curentQuestionIndex].questionText}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (gameManagment
                    .curentGame
                    .questions[(state as GameLoaded).curentQuestionIndex]
                    .image !=
                null)
              Image.network(
                gameManagment.curentGame
                    .questions[(state as GameLoaded).curentQuestionIndex].image,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            SizedBox(
              height: 20,
            ),
            ...gameManagment.curentGame
                .questions[(state as GameLoaded).curentQuestionIndex].options
                .map(
                  (e) => Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      onPressed: () {
                        // var nextIndex = gameManagment.answers.length;

                        gameManagment.answer(
                          questionId: gameManagment
                              .curentGame
                              .questions[
                                  (state as GameLoaded).curentQuestionIndex]
                              .questionId,
                          userAnswer: e,
                        );
                        if (gameManagment.answers.length ==
                            gameManagment.curentGame.questions.length) {
                          print("game${gameManagment.answers.length}");
                          showError(errorText: "Game over");
                        } else {
                          gameBloc.add(SetIndex(gameManagment.answers.length));
                        }

                        // showError(errorText: "Game is over");
                      },
                      child: Text(e),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      );

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
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
        height: 50,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) => GestureDetector(
            onTap: () {
              if (i < state.curentQuestionIndex ||
                  gameManagment.answers.firstWhere(
                          (element) =>
                              element.questionId ==
                              gameManagment.curentGame.questions[i].questionId,
                          orElse: () => null) !=
                      null) {
                gameBloc.add(SetIndex(i));
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: (MediaQuery.of(context).size.width -
                          (gameManagment.curentGame.questions.length - 1) * 10 -
                          20) /
                      gameManagment.curentGame.questions.length,
                  height: state.curentQuestionIndex == i ? 40 : 20,
                  decoration: BoxDecoration(
                    color: state.curentQuestionIndex == i
                        ? Colors.white
                        : gameManagment.answers.firstWhere(
                                    (element) =>
                                        element.questionId ==
                                        gameManagment
                                            .curentGame.questions[i].questionId,
                                    orElse: () => null) !=
                                null
                            ? Colors.green
                            : Colors.grey,
                    border: state.curentQuestionIndex == i
                        ? Border(
                            top: BorderSide(color: Colors.black, width: 2),
                            left: BorderSide(color: Colors.black, width: 2),
                            right: BorderSide(color: Colors.black, width: 2),
                            // bottom: BorderSide(color: Colors.white, width: 2),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          separatorBuilder: (c, i) => SizedBox(
            width: 10,
          ),
          itemCount: gameManagment.curentGame.questions.length,
        ),
      );
}
