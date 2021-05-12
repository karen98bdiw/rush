import 'package:rush/api/rush_api.dart';
import 'package:rush/models/custom_user.dart';

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
    return res;
  }
}
