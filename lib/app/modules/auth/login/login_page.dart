import 'package:cuidapet_mobile/app/core/helpers/eviroments.dart';

import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/icons/cuidapet_icons.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_textform_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/local_storage/local_storage.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  //------------------------ Teste de Escrita e Leitura
  // LoginPage({super.key}) {
  //   // Modular.get<LocalStorage>().write<String>('Teste1', "TEstes");
  //   Modular.get<LocalStorage>().write<int>('Teste2', 123456789);
  //   Future.delayed(const Duration(seconds: 2), () async {
  //     print(await Modular.get<LocalStorage>().read<int>('Teste2'));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Teste criação de tipos diferentes de LOG
    // var log = Modular.get<AppLogger>();
    // -----------------------------------------------------
    // log.append("Mensagem 1");
    // log.append("Mensagem 2");
    // log.append("Mensagem 3");
    // log.append("Mensagem 4");
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(Enviroments.param('base_url') ?? "VAZIO"),
              const Logo(),
              SizedBox(height: 20.h),
              const _LoginForm(),
              const _LoginRegisterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "ou",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: context.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
