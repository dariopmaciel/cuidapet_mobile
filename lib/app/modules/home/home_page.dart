import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {

  @override
  // TODO: implement params
  Map<String, dynamic>? get params => {'Teste':'Teste life cycle'};


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
