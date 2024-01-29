// import 'package:flutter/material.dart';
part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CuidapetTextFormField(label: "Login"),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            onPressed: () {
              //* ----> TESTE LOADER
              // Loader.show();
              // Future.delayed(const Duration(seconds: 2), () => Loader.hide(),);
              //* ----> TESTE MENSAGEM ERRO
              // Messages.alert("Mensagem de ERROR");
              //* ----> TESTE MENSAGEM INFO
              // Messages.info("Mensagem de INFORMAÇÃO");
            },
            label: "Entrar",
          ),
          const _OrSeparator(),
        ],
      ),
    );
  }
}
