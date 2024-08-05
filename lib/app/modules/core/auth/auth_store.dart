import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final AddressService _addressService;

  //readonly cria automaticamente os metodos getters e setters
  @readonly
  UserModel? _userLogged;

  AuthStoreBase({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required AddressService addressService,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _addressService = addressService;

  @action
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
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        //usuário deslogado do app
        logout();
      }
    });
  }

  // @action
  void logout() async {
    //usuário deslogado do app
    await _localStorage.clear();
    await _localSecureStorage.clear();
    await _addressService.deleteAll();
    _userLogged = UserModel.empty();
  }
}
