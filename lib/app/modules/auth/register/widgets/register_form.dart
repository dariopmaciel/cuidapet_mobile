part of '../register_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CuidapetTextFormField(label: 'Login'),
          const SizedBox(height: 20),
          CuidapetTextFormField(label: 'Senha', obscureText: true),
          const SizedBox(height: 20),
          CuidapetTextFormField(label: 'Confirma Senha', obscureText: true),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            label: 'Cadastrar',
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}
