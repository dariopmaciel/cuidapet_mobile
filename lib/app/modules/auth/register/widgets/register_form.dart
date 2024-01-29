part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

//! DESCONTINUADO -> ModularState
//class _RegisterFormState extends ModularState<_RegisterForm, RegisterController> {
class _RegisterFormState extends State<_RegisterForm> {
  final controller = Modular.get<RegisterController>();
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CuidapetTextFormField(
            label: 'Login',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("* Login obrigatório"),
              Validatorless.email("* Login deve ser um email válido"),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: 'Senha',
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required("*Senha obrigatória!"),
              Validatorless.min(6, 'Mínimo 6 caracteres!'),
              Validatorless.max(12, 'Máximo 12 caracteres!'),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: 'Confirma Senha',
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("* Confirma senha obrigatório!"),
              Validatorless.compare(_passwordEC, '* SENHAS NÃO CONFEREM!')
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
              label: 'Cadastrar',
              onPressed: () {
                final formaValid = _formKey.currentState?.validate() ?? false;
                if (formaValid) {
                  controller.register(
                      email: _loginEC.text, password: _passwordEC.text);
                }
              }),
        ]),
      ),
    );
  }
}
