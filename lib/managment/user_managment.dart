import 'package:rush/api/rush_api.dart';
import 'package:rush/models/api_models/api_response.dart';
import 'package:rush/models/custom_user.dart';
import 'package:rush/utils/diologs.dart';

class UserManagment {
  CustomUser curentUser;

  Future<ApiResponse<dynamic>> signUp({
    CustomUser model,
    String password,
  }) async {
    var res = await RushApi().userServices.signUp(
          model: model,
          password: password,
        );

    if (res.done && res.succses) {
      print("user created");
      print("response dat:${res.data}");
      var signRes = await signIn(
        email: model.email,
        password: password,
        firstSign: true,
      );
      return signRes;
    } else {
      showError(errorText: res.error.errorText);
      return res;
    }
  }

  Future<ApiResponse<bool>> signIn({
    String email,
    String password,
    bool firstSign = false,
  }) async {
    var res = await RushApi().userServices.signIn(
          email: email,
          password: password,
        );

    if (res.done && res.succses) {
      print("user created");
      print("response dat:${res.data.token}");
      if (firstSign) {
        var codeRes = await RushApi()
            .userServices
            .sendVerification(token: res.data.token);
        return ApiResponse(
          done: codeRes.done,
          succses: codeRes.succses,
          response: res.data.token,
        );
      } else {
        await getUserData(
          token: res.data.token,
        );
        return ApiResponse<bool>(
          done: true,
          succses: true,
        );
      }
    } else {
      showError(errorText: res.error.errorText);
    }
    return ApiResponse(
      done: false,
      succses: false,
    );
  }

  Future<void> getUserData({String token}) async {
    var res = await RushApi().userServices.getUserData(token: token);
    if (res.succses && res.done) {
      curentUser = res.data;
    } else {
      showError(errorText: res.error.errorText);
    }
    return res;
  }
}
