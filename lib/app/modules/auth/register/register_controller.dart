import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  //Por ser um atributo privado é necessário receber ele, pasra que NGM tenha acesso direto ao USERSERVICE
  _RegisterControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> register(
      {required String email, required String password}) async {
    try {
      Loader.show();
      // await Future.delayed(const Duration(seconds: 2));
      await _userService.register(email, password);
      Loader.hide();
    } on UserExistsException {
      Loader.hide();
      Messages.alert("Email já utilizado");
    } catch(e,s){
      _log.error("Erro ao registrar usuário", e, s);
      Loader.hide();
      Messages.alert("Erro ao registrar usuário.");
    }
  }
}
