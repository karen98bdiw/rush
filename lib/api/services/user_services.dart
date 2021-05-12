import 'package:dio/dio.dart';
import 'package:rush/api/dio_base.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/custom_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class UserServices {
  final DioBase dioBase;

  UserServices({this.dioBase});

  Future<ApiResponse<CustomUser>> signUp(
      {CustomUser model, String password}) async {
    Map<String, dynamic> params = model.toRegJson();
    params["password"] = password;
    var res = await dioBase.post<CustomUser>(
      endPoint: DotEnv.env["SIGN_UP_POINT"],
      data: FormData.fromMap(params),
    );

    return res;
  }

  Future<ApiResponse<CustomUser>> signIn({
    String email,
    String password,
  }) async {
    var res = await dioBase.get<CustomUser>(
        endPoint: DotEnv.env["SIGN_IN_POINT"],
        additionalParams: {
          "email": email,
          "password": password,
        });
    return res;
  }
}
