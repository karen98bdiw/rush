import 'package:dio/dio.dart';
import 'package:rush/api/api_constats.dart';
import 'package:rush/models/api_models/api_error.dart';
import 'package:rush/models/api_models/api_response.dart';

class DioBase {
  var _dio = Dio();

  Future<ApiResponse<T>> get<T>(
      {String endPoint, Map<String, dynamic> additionalParams}) async {
    Map<String, dynamic> params = {};
    if (additionalParams != null) {
      additionalParams.forEach((key, value) {
        params[key] = value;
      });
    }
    try {
      var res = await _dio.get(
        ApiConstats.Base_Url + endPoint,
        queryParameters: params,
        options: Options(headers: ApiConstats.Header),
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
      return ApiResponse<T>(
        done: false,
        error: ApiError(errorText: e.toString()),
      );
    }
  }
}
