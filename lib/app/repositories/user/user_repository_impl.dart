import 'package:cuidapet_mobile/app/core/exceptions/failue.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exits_exceptions.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_cliente/rest_client_exception.dart';

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
  Future<void> register(String email, String password) async {
    try {
      await _restClient.unauth().post('/auth/register', data: {
        'email': email,
        'password': password,
      });
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message'].contains['Usuário já cadastrado']) {
        _log.error(e.error, e, s);
        throw UserExitsExceptions();
      }
      _log.error("Erro ao cadastrar usuário", e, s);
      throw Failue(message: 'Error ao registrar usuario');
    }
  }
}
