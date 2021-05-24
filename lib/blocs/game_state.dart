import 'package:flutter/cupertino.dart';

@immutable
abstract class GameState {
  const GameState();
}

class GameLoaded extends GameState {
  final int curentQuestionIndex;
  const GameLoaded(this.curentQuestionIndex);
}
