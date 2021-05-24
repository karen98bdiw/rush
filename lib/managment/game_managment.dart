import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rush/api/rush_api.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/game_response.dart';

class GameManagment extends ChangeNotifier {
  GameResponse curentGame;

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
