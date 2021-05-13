import 'package:rush/models/api_models/api_error.dart';
import 'package:rush/models/custom_user.dart';
import 'package:rush/models/sign_in_response.dart';

class ApiResponse<T> {
  final bool done;
  final bool succses;
  final ApiError error;
  final dynamic response;
  ApiResponse(
      {this.response, this.done = false, this.error, this.succses = false});

  parsedData() {
    switch (T) {
      case CustomUser:
        return CustomUser.fromJson(this.response);
        break;
      case SignInResponse:
        return SignInResponse.fromJson(this.response);
        break;

      default:
        return response;
    }
  }

  T get data => done ? parsedData() as T : null;
}
