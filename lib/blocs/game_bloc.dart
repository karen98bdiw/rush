import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rush/blocs/game_event.dart';
import 'package:rush/blocs/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameLoaded(7));

  int index;

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event.runtimeType == SetIndex) {
      index = (event as SetIndex).index;
      yield GameLoaded(index);
    }
  }
}
