import 'package:dio/dio.dart';
import 'package:rush/models/api_models/api_error.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class DioBase {
  var _dio = Dio();

  ///dio custom post request
  Future<ApiResponse<T>> post<T>({
    String endPoint,
    Map<String, dynamic> additionalParams,
    dynamic data,
  }) async {
    Map<String, dynamic> params = {};
    if (additionalParams != null) {
      additionalParams.forEach((key, value) {
        params[key] = value;
      });
    }
    try {
      var res = await _dio.post(
        DotEnv.env["ROOT_URL_DEV"] + endPoint,
        data: data,
        queryParameters: params,
        options: Options(),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ApiResponse<T>(
          done: true,
          succses: true,
          response: res.data,
        );
      }
      return ApiResponse<T>(
        done: false,
        error: ApiError(errorText: res.data.toString()),
      );
    } catch (e) {
      print("dio basedd errror ${e.message}");
      return ApiResponse<T>(
        done: false,
        error: ApiError(errorText: e.toString()),
      );
    }
  }

  ///dio custom get request
  Future<ApiResponse<T>> get<T>(
      {String endPoint,
      Map<String, dynamic> additionalParams,
      dynamic data}) async {
    Map<String, dynamic> params = {};
    if (additionalParams != null) {
      additionalParams.forEach((key, value) {
        params[key] = value;
      });
    }
    try {
      var res = await _dio.get(
        DotEnv.env["ROOT_URL_DEV"] + endPoint,
        queryParameters: additionalParams,
        options: Options(),
      );

      if (res.statusCode == 200) {
        return ApiResponse<T>(
          done: true,
          succses: true,
          response: res.data,
        );
      }
      return ApiResponse<T>(
        done: false,
        error: ApiError(errorText: res.data.toString()),
      );
    } catch (e) {
      print("dio basedd errror ${e.message}");
      return ApiResponse<T>(
        done: false,
        error: ApiError(errorText: e.toString()),
      );
    }
  }
}
