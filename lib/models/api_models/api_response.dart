import 'package:rush/models/api_models/api_error.dart';

class ApiResponse<T> {
  final bool done;
  final bool succses;
  final ApiError error;
  final dynamic response;
  ApiResponse(
      {this.response, this.done = false, this.error, this.succses = false});

  parsedData() {
    switch (T) {
      // case CustomUser:
      //   return CustomUser.fromJson(this.response);
      //   break;
      // case CharacterWrapper:
      //   return CharacterWrapper.fromJson(this.response);
      //   break;

      default:
        this.response as T;
    }
  }

  T get data => done ? parsedData() as T : null;
}
