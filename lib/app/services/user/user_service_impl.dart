import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/models/social_login_type.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSegureStorage;
  final SocialRepository _socialRepository;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required SocialRepository socialRepository,
  })  : _userRepository = userRepository,
        _log = log,
        _localStorage = localStorage,
        _localSegureStorage = localSecureStorage,
        _socialRepository = socialRepository;

  @override
  Future<void> register(String email, String password) async {
    try {
      //teste de erro
      // throw Failure(message: 'teste de erro');
      //
      final firebaseAuth = FirebaseAuth.instance;
      // ignore: deprecated_member_use
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
      // ignore: deprecated_member_use
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      //se não é vazio
      // print("Verifica se a String é valida $loginMethods");
      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      // print("Achou o login por password");
      if (loginMethods.contains('password')) {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        //VERIFICA SE EMAIL FOI CONFIRMADO E CASO NÃO ENVIA NOVO EMAIL
        final userVerified = userCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          userCredential.user?.sendEmailVerification();
          throw Failure(
              message: "Email não confirmado, verifique sua caixa de SPAM");
        }

        // print("Email verificado = OK");

        final accessToken = await _userRepository.login(email, password);
        await _saveAccessToken(accessToken);
        //*------------Teste
        // final xx = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
        // print("A CHAVE É: $xx");
        //*------------Teste funcinando
        // Modular.get<RestClient>().auth().get('/auth/confirm');
        await _confirmLogin();
        await _getUserData();
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

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSegureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
        confirmLoginModel.refreshToken);
  }

  Future<void> _getUserData() async {
    final userModel = await _userRepository.getUserLogged();
    //SEREALIZAÇÃO do usuário para facilitar sua recuperação de perfil
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY, userModel.toJson());
  }

  @override
  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      final SocialNetworkModel socialModel;
      final AuthCredential authCredential;
      final firebaseAuth = FirebaseAuth.instance;

      switch (socialLoginType) {
        case SocialLoginType.facebook:
          socialModel = await _socialRepository.facebookLogin();
          authCredential =
              FacebookAuthProvider.credential(socialModel.accessToken);
          break;
//!----------------------------------------------------
        case SocialLoginType.google:
          socialModel = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
            accessToken: socialModel.accessToken,
            idToken: socialModel.id,
          );
          break;
      }
      final loginMethods =
          // ignore: deprecated_member_use
          await firebaseAuth.fetchSignInMethodsForEmail(socialModel.email);
      final methodCheck = _getMethodSocialLoginType(socialLoginType);

      // if (loginMethods.isNotEmpty && !loginMethods.contains('google.com')) {
      if (loginMethods.isNotEmpty && !loginMethods.contains(methodCheck)) {
        throw Failure(
            message:
                "Login não poder ser feito por $methodCheck, por favor utilize outro método!");
      }

      await firebaseAuth.signInWithCredential(authCredential);
      final accessToken = await _userRepository.loginSocial(socialModel);
      await _saveAccessToken(accessToken);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _log.error("Erro ao realizar login com $socialLoginType", e, s);

      throw Failure(message: "Erro ao realizar login");
    }
  }

  String _getMethodSocialLoginType(SocialLoginType socialLoginType) {
    switch (socialLoginType) {
      case SocialLoginType.facebook:
        return 'facebook.com';
      case SocialLoginType.google:
        return 'google.com';
    }
  }
}
