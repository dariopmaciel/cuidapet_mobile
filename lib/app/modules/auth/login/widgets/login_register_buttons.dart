// import 'package:flutter/material.dart';
part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          RoundedButtonWithIcon(
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Btn Google')));
            },
            widht: .42.sw,
            color: const Color(0xffe15031),
            icon: CuidapetIcons.google,
            label: 'Google',
          ),
          RoundedButtonWithIcon(
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Btn Facebook')));
            },
            widht: .42.sw,
            color: const Color(0xff4267B3),
            icon: CuidapetIcons.facebook,
            label: 'Facebook',
          ),
          RoundedButtonWithIcon(
            onTap: () {
              //TESTE
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(const SnackBar(content: Text('Btn Cadastro')));
              Navigator.pushNamed(context, '/register/');
            },
            widht: .42.sw,
            color: context.primaryColorDark,
            icon: CuidapetIcons.mail,
            label: 'Cadastre-se',
          ),
        ],
      ),
    );
  }
}
