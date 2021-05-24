abstract class GameEvent {}

class SetIndex extends GameEvent {
  final int index;
  SetIndex(this.index);
}
