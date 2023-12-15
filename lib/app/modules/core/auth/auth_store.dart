import 'package:cuidapet_mobile/app/models/user_models.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
// O novo mobx'@readonly' implementa automaticamente metodos gets e sets
  @readonly
  UserModels? _userLogged;

  @action
  Future<void> loaderUserLogged() async {
    _userLogged = UserModels.empty();

    // Future.delayed(const Duration(seconds: 3), () {
    //   _userLogged = UserModels.fromMap({"email": "dario"});
    // });
  }
}
