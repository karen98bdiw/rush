import 'package:rush/api/rush_api.dart';
import 'package:rush/models/custom_user.dart';
import 'package:rush/utils/diologs.dart';

class UserManagment {
  CustomUser curetUser;

  Future<dynamic> signUp({
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
    } else {
      showError(errorText: res.error.errorText);
    }
    return res;
  }

  Future<dynamic> signIn({
    String email,
    String password,
  }) async {
    var res = await RushApi().userServices.signIn(
          email: email,
          password: password,
        );

    if (res.done && res.succses) {
      print("user created");
      print("response dat:${res.data.token}");
      await getUserData(token: res.data.token);
    } else {
      showError(errorText: res.error.errorText);
    }
    return res;
  }

  Future<void> getUserData({String token}) async {
    var res = await RushApi().userServices.getUserData(token: token);
    if (res.succses && res.done) {
    } else {
      showError(errorText: res.error.errorText);
    }
    return res;
  }
}
