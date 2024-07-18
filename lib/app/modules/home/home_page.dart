import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            ),
            TextButton(
              onPressed: () async {
                // print('Teste Refresh Token');
                // final categoriesResponse =
                //     await Modular.get<RestClient>().auth().get('/categories/');
                // print(categoriesResponse.data);
              },
              child: const Text('Teste Refresh Token'),
            ),
          ],
        ),
      ),
    );
  }
}
