import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/models/user_models.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
// import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;

  const AuthHomePage({
    super.key,
    required AuthStore authStore,
  }) : _authStore = authStore;

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  //fica escutando usuário logado
  @override
  void initState() {
    super.initState();
    reaction<UserModels?>(
      (_) => widget._authStore.userLogged,
      (userlogger) {
        if (userlogger != null && userlogger.email.isNotEmpty) {
          Modular.to.navigate('/home/');
        } else {
          Modular.to.navigate('/auth/login/');
        }
      },
    );
    //se não tiver nada ele irá carregar como vazio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._authStore.loaderUserLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    //confirmação do 'flutter_screenutil'
    // print("Largura da Tela: ${162.w}");
    // print("Altura da tela: ${130.h}");

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      //substituido por:
      // backgroundColor: context.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          //A adição do 'flutter_screenutil' juntamnete ao '.w e .h'
          //adaptam o tamanho da imagem á tela em escala
          width: 162.w,
          height: 130.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
