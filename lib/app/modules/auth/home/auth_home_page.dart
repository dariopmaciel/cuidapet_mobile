import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;

  const AuthHomePage({
    super.key,
    required AuthStore authStore,
  })  : _authStore = authStore;

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  void initState() {
    super.initState();
    

    //*REACTION VE OLHA DENTRO DA AUTHSTORE, VARIAVEL USERLOGGED
    reaction<UserModel?>((_) => widget._authStore.userLogged, (userLogged) {
      if (userLogged != null && userLogged.email.isNotEmpty) {
        Modular.to.navigate('/home/');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._authStore.loadUserLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor, criado a Extension em  app\core\ui\extensions\theme_extension.dart e substituido por:
      // backgroundColor: context.primaryColor,
      // appBar: AppBar(title: const Text("data")),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', 
          width: 162.w,
          height: 130.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
