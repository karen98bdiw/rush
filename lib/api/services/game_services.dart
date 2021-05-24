import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rush/api/dio_base.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/game_response.dart';

class GameServices {
  DioBase dioBase;

  GameServices({this.dioBase});

  Future<ApiResponse<GameResponse>> pick({String token}) async {
    print("toke in service $token");
    var res = await dioBase.get<GameResponse>(
      endPoint: "/v1/play/pick",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
    );

    return res;
  }

  Future<ApiResponse<GameResponse>> pickById({String token, String id}) async {
    print("id in service $id");

    var res = await dioBase.get<GameResponse>(
      endPoint: "/play/questions/?playId=$id",
      // additionalParams: {
      //   "playId": id,
      // },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
    );
    print("pick by id resp ${res.response}");
    return res;
  }
}
