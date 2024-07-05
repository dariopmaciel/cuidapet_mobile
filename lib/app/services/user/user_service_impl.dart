import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;
  final LocalStorage _localStorage;
  // final LocalSecureStorage _localSecureStore;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
    required LocalStorage localStorage,
    // required LocalSecureStorage localSecureStore,
  })  : _userRepository = userRepository,
        _log = log,
        _localStorage = localStorage;
  // _localSecureStore = localSecureStore;

  @override
  Future<void> register(String email, String password) async {
    try {
      //teste de erro
      // throw Failure(message: 'teste de erro');
      //
      final firebaseAuth = FirebaseAuth.instance;
      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      //se não for vazio
      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }
      //caso vazio, usuário não esta cadastrado, cadastrar usuário no backend
      await _userRepository.register(email, password);
      //se sucesso
      final userRegisterCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //Se criou registrodentro do firebase, busca o usuário para envio de confirmação de email
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuário no Firebase", e, s);
      throw Failure(message: "Erro ao crial usuário");
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      //se não é vazio
      print("Verifica se a String é valida $loginMethods");
      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      print("Achou o login por password");
      if (loginMethods.contains('password')) {
        final UserCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        //VERIFICA SE EMAIL FOI CONFIRMADO E CASO NÃO ENVIA NOVO EMAIL
        final userVerified = UserCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          UserCredential.user?.sendEmailVerification();
          throw Failure(
              message: "Email não confirmado, verifique sua caixa de SPAM");
        }

        print("Email verificado = OK");

        final accessToken = await _userRepository.login(email, password);
        await _saveAccessToken(accessToken);
        //------------Teste
        // final xx = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
        // print("A CHAVE É: $xx");
        //!------------Teste Nõa ta funcinando o teste
        Modular.get<RestClient>().auth().get('/auth/confirm');
        //------------Teste
      } else {
        throw Failure(
            message:
                'Login não pode ser feito por email e password. Utilize outro método.');
      }
    } on FirebaseAuthException catch (e, s) {
      // print('Tipo de erro no firebase: $e'); colocar ponto
      _log.error(
          'Usuário ou senha inválidos FirebaseAuthError[${e.code}]', e, s);
      throw Failure(message: "Usuário ou senha inválidos!!!");
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);
}
