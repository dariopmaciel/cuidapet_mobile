import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/services/user/user_services.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserServices _userService;
  final AppLogger _log;

  RegisterControllerBase({
    required UserServices userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;
  Future<void> register({required String email, required String senha}) async {
    Loader.show();
    await Future.delayed(const Duration(seconds: 2));
    Loader.hide();
  }
}
