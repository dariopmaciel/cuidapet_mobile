// ignore_for_file: unused_field

import 'package:cuidapet_mobile/app/core/exceptions/user_exits_exceptions.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';

part 'register_controller.g.dart';

// ignore: library_private_types_in_public_api
class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  _RegisterControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;
  Future<void> register({required String email, required password}) async {
    try {
      Loader.show();
      await _userService.register(email, password);
      // await Future.delayed(const Duration(seconds: 2));
      Messages.info("Enviamos um email de confirmação, por favor olhe sua caixa de email");
      Loader.hide();
    } on UserExitsExceptions {
      Loader.hide();
      Messages.alert('Email já utilizado. Por favor escolha outro!');
    }catch(e,s){
      _log.error("Erro ao registrar usuário", e, s);
      Loader.hide();
      Messages.alert("Erro ao registrar usuário");
    }
  }
}
