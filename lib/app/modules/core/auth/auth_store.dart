import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;

  //readonly cria automaticamente os metodos getters e setters
  @readonly
  UserModel? _userLogged;

  AuthStoreBase({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  Future<void> loadUserLogged() async {
    //usado para extrair os dados internos
    //Usuário LOGADO
    final userModelJson = await _localStorage
        .read<String>(Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY);
    if (userModelJson != null) {
      //se nulo usuário não logado
      _userLogged = UserModel.fromJson(userModelJson);
    } else {
      //se não for nulo, usuario logado
      _userLogged = UserModel.empty();
    }
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        //usuário deslogado do app
        await _localStorage.clear();
        _userLogged = UserModel.empty();
      }
    });
  }
}
