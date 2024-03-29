import 'package:firebase_auth/firebase_auth.dart';

import 'package:cuidapet_mobile/app/core/exceptions/failue.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exits_exceptions.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _userRepository;

  UserServiceImpl(
      {required AppLogger log, required UserRepository userRepository})
      : _log = log,
        _userRepository = userRepository;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userMethods.isNotEmpty) {
        throw UserExitsExceptions();
      }
      await _userRepository.register(email, password);
      final userRegisterCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuário no Firebase", e, s);
      throw Failue(message: 'Erro ao criar usuário');
    }
  }
}
