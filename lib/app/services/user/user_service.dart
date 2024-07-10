import 'package:cuidapet_mobile/app/models/social_login_type.dart';

abstract interface class UserService {
  // Future<void> register(String email, String password) async {}
  Future<void> register(String email, String password);
  Future<void> login(String email, String password);
  Future<void> socialLogin(SocialLoginType socialLoginType);
}
