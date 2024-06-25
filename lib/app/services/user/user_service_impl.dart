import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;
  //instancia para gravar no firebase
  final LocalStorage _localStorage;

  UserServiceImpl({
    required AppLogger log,
    required UserRepository userRepository,
    required LocalStorage localStorage,
  })  : _log = log,
        _userRepository = userRepository,
        _localStorage = localStorage;

  @override
  Future<void> register(String email, String password) async {
    try {
      // throw Failure();
      final firebaseAuth = FirebaseAuth.instance;

      final userMethod = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userMethod.isNotEmpty) {
        throw UserExistsException();
      }
      await _userRepository.register(email, password);
      final userRegisteCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userRegisteCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuário no firebase', e, s);
      throw Failure(message: 'Erro ao criar usuário');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final firebaseAuth = await FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      if (loginMethods.contains('password')) {
        print("Achou login por password dentro com console do FirebaseAuth");
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        final userVerified = userCredential.user?.emailVerified ?? false;

        if (!userVerified) {
          userCredential.user?.sendEmailVerification();
          throw Failure(
              message: "Email não confirmado, Verifique sua caixa de SPAM");
        }
        print('Email verificado');
        //
        final accessToken = await _userRepository.login(email, password);
        await _saveAccessToken(accessToken);
        final xx = await _localStorage.read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
        print('Imprimindo o TOKEN: [$xx]');
        //
      } else {
        throw Failure(
            message:
                "Login não pode ser feito por email e password, por favor utilize outro método!");
      }
    } on FirebaseAuthException catch (e, s) {
      _log.error(
        "Usuário ou senha inválidos Firebaseauth [${e.code}]",
        e,
        s,
      );
      throw Failure(message: "Usuário ou senha inválidos!!!!");
    }
    // print(loginMethods);
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);
}
