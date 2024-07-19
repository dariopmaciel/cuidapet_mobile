part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final controller = Modular.get<LoginController>();
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
            label: 'Login',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("*Login Obrigatório!"),
              Validatorless.email('*Email Inválido!'),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: 'Senha',
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required("*Senha Obrigatória!"),
              Validatorless.min(6, '*Mínimo de 6 caracteres!'),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            label: 'Entrar',
            onPressed: () async {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                await controller.login(_loginEC.text, _passwordEC.text);
              }
              // Loader.show();
              // () => Loader.hide(),
              //ou assim
              Future.delayed(const Duration(seconds: 2), Loader.hide);
            },
          ),
        ],
      ),
    );
  }
}
