import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
  })  : _userRepository = userRepository,
        _log = log;

  @override
  Future<void> register(String email, String password) async {
    try {
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
      //Busca o usuário para envio de confirmação de email
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuário no Firebase",e,s);
      throw Failure(message: "Erro ao crial usuário");

    }
  }

  @override
  Future<void> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
