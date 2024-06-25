import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl({
    required AppLogger log,
    required UserRepository userRepository,
  })  : _log = log,
        _userRepository = userRepository;

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
    final firebaseAuth = await FirebaseAuth.instance;
    final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

    if (loginMethods.isEmpty) {
      throw UserNotExistsException();
    }

    if (loginMethods.contains('password')) {
      print("Achou login por password!");
    } else {
      throw Failure(
          message:
              "Login não pode ser feito por email e password, por favor utilize outro método!");
    }

    print(loginMethods);
  }
}
