
import 'package:cuidapet_mobile/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module{

  @override
  void routes(RouteManager r) {
    
    super.routes(r);
    r.child(Modular.initialRoute, child: (_) =>  LoginPage());
  }
  
}