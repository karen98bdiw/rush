import 'package:rush/api/dio_base.dart';
import 'package:rush/api/services/game_services.dart';
import 'package:rush/api/services/user_services.dart';

class RushApi {
  RushApi._internal();

  static final RushApi rushApi = RushApi._internal();

  static final DioBase _dioBase = DioBase();

  factory RushApi() => rushApi;

  final UserServices userServices = UserServices(
    dioBase: _dioBase,
  );

  final GameServices gameServices = GameServices(
    dioBase: _dioBase,
  );
}
