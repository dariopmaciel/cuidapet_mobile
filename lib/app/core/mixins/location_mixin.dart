import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef TryAgain = void Function();

//quando disponivel para classes State, tras um 'context' disponivel para a classe usada
mixin LocationMixin<E extends StatefulWidget> on State<E> {
  void showDialogLocationServiceUnavailable() {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua localização'),
          content: const Text(
              'Pare realizar a busca da sua localização, ative o GPS.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                Geolocator.openLocationSettings();
              },
              child: const Text('Configurações'),
            ),
          ],
        );
      },
    );
  }

  void showDialogLocationDenied({TryAgain? tryAgain}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
              'Pare realizar a busca da sua localização, autorize sua utilização.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                if (tryAgain != null) {
                  tryAgain();
                }
                // Geolocator.openLocationSettings();
              },
              child: const Text('Tentar Novamente'),
            ),
          ],
        );
      },
    );
  }

  void showDialogLocationDeniedForever() {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: const Text('Precisamos da sua autorização'),
          content: const Text(
              'Pare realizar a busca da sua localização, autorize sua utilização. Clique no botão configurações e autorize  utilização e clique novamente no botão Localização atual'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextDialog);
                Geolocator.openLocationSettings();
              },
              child: const Text('Abrir Configurações'),
            ),
          ],
        );
      },
    );
  }
}
