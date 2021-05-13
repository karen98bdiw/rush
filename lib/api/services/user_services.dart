import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rush/api/dio_base.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/custom_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:rush/models/sign_in_response.dart';

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
    await signIn(
      email: model.email,
      password: password,
    );
    return res;
  }

  Future<ApiResponse<SignInResponse>> signIn({
    String email,
    String password,
  }) async {
    var res = await dioBase.post<SignInResponse>(
      endPoint: DotEnv.env["SIGN_IN_POINT"],
      data: {
        "email": email,
        "password": password,
      },
    );

    return res;
  }

  Future<ApiResponse<CustomUser>> getUserData({String token}) async {
    var res = await dioBase.get<CustomUser>(
      endPoint: DotEnv.env["USER_GET_PROFILE"],
      options: Options(headers: {
        HttpHeaders.authorizationHeader: token,
      }),
    );

    return res;
  }

  Future<ApiResponse<bool>> sendVerification({
    String token,
  }) async {
    print("sending verification");
    var res = await dioBase.get<bool>(
      endPoint: "/auth/send-verification",
      options: Options(headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      }),
    );

    return res;
  }

  Future<ApiResponse<bool>> verifyEmail(
    String email,
    String code,
    String token,
  ) async {
    var res = await dioBase.post<bool>(
      endPoint: "/auth/verify-code",
      data: {
        "email": email,
        "code": code,
      },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
    );

    return res;
  }
}
