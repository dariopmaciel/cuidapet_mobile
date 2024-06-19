// import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
// import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
// import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
// import 'package:cuidapet_mobile/app/core/rest_client/rest_clienteException.dart';
// import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';

// import './user_repository.dart';

// class UserRepositoryImpl implements UserRepository {
//   final RestClient _restClient;
//   final AppLogger _log;

//   UserRepositoryImpl({
//     required RestClient restClient,
//     required AppLogger log,
//   })  : _restClient = restClient,
//         _log = log;

//   @override
//   Future<void> register(String email, String password) async {
//     try {
//       await _restClient.unAuth().post('/auth/register', data: {
//         email: 'email',
//         password: 'password',
//       });
//     } on RestClientException catch (e, s) {
//       if (e.statusCode == 400 &&
//           e.response.data['message'].contais('Usuário já cadastrado')) {
//         _log.error(e.error, e, s);
//         throw UserExistsException();
//       }
//       _log.error('Erro ao cadastrar usuário', e, s);
//       throw Failure(message: 'Erro ao registrar usuário');
//     }
//   }
// }

import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
// corrigido aqui
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_clienteException.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<void> register(
    String email,
    String password,
  ) async {
    try {
      await _restClient.unAuth().post('/auth/register', data: {
        'email': email, // corrigido aqui
        'password': password, // corrigido aqui
      });
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message'].contains('Usuário já cadastrado')) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }
      _log.error('Erro ao cadastrar usuário', e, s);
      throw Failure(message: 'Erro ao registrar usuário');
    }
  }
}
