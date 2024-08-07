import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/icons/cuidapet_icons.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_textform_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:cuidapet_mobile/app/models/social_login_type.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';
part 'widgets/login_form.dart';
part 'widgets/login_register_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  /*//-> LocalStorage--------- Teste de Escrita e Leitura 
  LoginPage({super.key}) {
    Modular.get<LocalStorage>().write<String>('Teste1', "Teste de -> LocalStorage");
    Modular.get<LocalStorage>().write<int>('Teste2', 123456789);
    Modular.get<LocalStorage>().write('teste3', 'Testeee');
    
    Future.delayed(const Duration(seconds: 2), () async {
      print(await Modular.get<LocalStorage>().read<String>('Teste1'));
    });
    Future.delayed(const Duration(seconds: 2), () async {
      print(await Modular.get<LocalStorage>().read<int>('Teste2'));
    });
    Future.delayed(const Duration(seconds: 2), () async {
      print(await Modular.get<LocalStorage>().read('teste3'));
    });
  }*/

  /*//-> LocalSecureStorage ---- Teste de Escrita e Leitura
  LoginPage({super.key}) {
    Modular.get<LocalSecureStorage>().write('Teste1', "Teste de -> LocalSecureStorage");
    
    
    Future.delayed(const Duration(seconds: 2), () async {
      print(await Modular.get<LocalSecureStorage>().read('Teste1'));
    });
   
  }*/

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------
    // Teste criação de tipos diferentes de LOG
    // var log = Modular.get<AppLogger>();
    // -----------------------------------------------------
    // log.append("Mensagem 1");
    // log.append("Mensagem 2");
    // log.append("Mensagem 3");
    // log.append("Mensagem 4");
    //! FUNDAMENTAL TER O CLOSE APPEND
    // log.closeAppend();
    // -----------------------------------------------------
    // log.debug('Debug', "debug", StackTrace.current);
    // -----------------------------------------------------
    // log.error('Error X', "Errorx", StackTrace.current);
    // -----------------------------------------------------
    // log.warnning('Warnning', 'warnning', StackTrace.current);
    // -----------------------------------------------------
    // log.info('Info', "Info", StackTrace.current);
    // -----------------------------------------------------

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              // Text(Environments.param('base_url') ?? ""),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 162.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20.h),
              const _LoginForm(),
              SizedBox(height: 8.h),
              const _OrSeparator(),
              SizedBox(height: 8.h),
              _LoginRegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 1, color: context.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OU',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: context.primaryColor),
          ),
        ),
        Expanded(
          child: Divider(thickness: 1, color: context.primaryColor),
        ),
      ],
    );
  }
}
