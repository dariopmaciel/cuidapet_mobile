import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl(
      {required UserRepository userRepository, required AppLogger log})
      : _userRepository = userRepository,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    //verificação para ver se o user e stácadastrado dentro da base do firebase
    // throw UnimplementedError();
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userdMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (userdMethods.isNotEmpty) {
        throw UserExistsException();
      }
      await _userRepository.register(email, password);
      final userRegisterCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuário no Firebase", e, s);
      throw Failure(message: "Erro ao criar usuário");
    }
  }
}
