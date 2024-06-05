import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  //readonly cria automaticamente os metodos getters e setters
  @readonly
  UserModel? _userLogged;

  Future<void> loadUserLogged() async {
    _userLogged = UserModel.empty();

    // Future.delayed(const Duration(seconds: 3),(){
    //   _userLogged = UserModel.fromMap({'email':'Dario Maciel', 'registerType': 'XXX', 'imgAvatar':'XXX'});
    // });
  }
}


