part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CuidapetTextFormField(
              label: "Login",
              controller: _loginEC,
              validator: Validatorless.multiple([
                Validatorless.required('* Digite um email.'),
                Validatorless.email("* E-mail precisa ser válido"),
              ]),
            ),
            const SizedBox(height: 20),
            CuidapetTextFormField(
              label: "Senha",
              obscureText: true,
              controller: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required("* Senha obrigatória!"),
                Validatorless.min(3, "* Mínimo 3 caracteres!"),
                Validatorless.max(20, "* Mínimo 20 caracteres!"),
              ]),
            ),
            const SizedBox(height: 20),
            CuidapetTextFormField(
              label: "Confirma Senha",
              obscureText: true,
              validator: Validatorless.multiple([
                Validatorless.required("* Confirmação Obrigatória!"),
                Validatorless.min(3, "* Mínimo 3 caracteres!"),
                Validatorless.max(20, "* Mínimo 20 caracteres!"),
                Validatorless.compare(_passwordEC, "** Não confere com Senha")
              ]),
            ),
            const SizedBox(height: 40),
            CuidapetDefaultButton(
              onPressed: () {
                final formValid = _formKey.currentState!.validate()?? false;
                if (formValid) {
                  // controller.register(
                  //     email: _loginEC.text, password: _passwordEC.text);
                }
                // if (_formKey.currentState!.validate()) {
                //   print('Valid');
                // } else {
                //   print('Invalid');
                // }
              },
              label: "Cadastrar",
            ),

            //
          ],
        ),
      ),
    );
  }
}
