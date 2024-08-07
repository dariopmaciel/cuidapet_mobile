import 'package:cuidapet_mobile/app/models/social_network_model.dart';

abstract class SocialRepository {
  Future<SocialNetworkModel> facebookLogin();
  Future<SocialNetworkModel> googleLogin();
}
