part of '../login_page.dart';

class _LoginRegisterButton extends StatelessWidget {
  const _LoginRegisterButton({super.key});

  IconData? get icon => null;

  @override
  Widget build(BuildContext context) {
    //O WRAP calcula automaticamente se os filhos dele encontra o final e quebra linha mantendo todos em um unico Wrap
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        RoundedButtonWithIcon(
            onTap: () {},
            width: .42.sw,
            color: const Color(0xFF4267B3),
            label: 'Facebook',
            icon: CuidapetIcons.facebook),
        RoundedButtonWithIcon(
            onTap: () {},
            width: .42.sw,
            color: const Color(0xFFe15031),
            label: 'Google',
            icon: CuidapetIcons.google),
        RoundedButtonWithIcon(
            onTap: () {
              Navigator.pushNamed(context, '/auth/register');
            },
            width: .42.sw,
            color: context.primaryDark,
            label: 'Cadastre-se',
            icon: CuidapetIcons.mail),
      ],
    );
  }
}
