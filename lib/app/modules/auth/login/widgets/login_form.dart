// import 'package:flutter/material.dart';
part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            label: "Login",
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("*Login Obrigatório"),
              Validatorless.email("*E-mail Obrigatório!")
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: "Senha",
            obscureText: true,
            controller: _passwordEC,
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
