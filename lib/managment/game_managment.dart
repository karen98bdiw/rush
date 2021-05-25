import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rush/api/rush_api.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/game_response.dart';

class ColectedAnswer {
  final String questionId;
  String answer;

  ColectedAnswer({this.answer, this.questionId});
}

class GameManagment extends ChangeNotifier {
  GameResponse curentGame;

  List<ColectedAnswer> answers = [];

  void answer({String questionId, String userAnswer}) {
    var index =
        answers.indexWhere((element) => element.questionId == questionId);

    if (index == -1) {
      answers.add(
        ColectedAnswer(answer: userAnswer, questionId: questionId),
      );
    } else {
      answers[index].answer = userAnswer;
    }

    print(answers);
  }

  void clearAnswers() {
    answers = [];
  }

  Future<ApiResponse<GameResponse>> pick({String token}) async {
    var res = await RushApi().gameServices.pick(
          token: token,
        );

    print("response from pick managment ${res.response}");
    if (res.done && res.succses) {
      var pickedGame = await pickById(id: res.response["playId"], token: token);
      print("pickedGame ${pickedGame.response}");
      Clipboard.setData(
        ClipboardData(text: pickedGame.response.toString()),
      );
      curentGame = pickedGame.data;
      return pickedGame;
    } else {
      print("error in pick request");

      return res;
    }
  }

  Future<ApiResponse<GameResponse>> pickById({String id, String token}) async {
    var res = await RushApi().gameServices.pickById(
          id: id,
          token: token,
        );

    if (res.done && res.succses) {
      return res;
    }

    return ApiResponse(
      done: true,
      succses: false,
    );
  }
}
