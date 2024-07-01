import 'package:cuidapet_mobile/app/models/confirm_login_model.dart';

abstract interface class UserRepository {
  //
  Future<void> register(String email, String password);

  //String pois retornará o access token
  Future<String> login(String email, String password);
  Future<ConfirmLoginModel> confirmLogin();
}
