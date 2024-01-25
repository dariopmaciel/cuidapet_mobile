//! OVERLAY É UM CARA QUE FICA SEEEEMPRE SOBRE TODAS AS PÁGINAS
//* OVERLAY É UM CARA QUE FICA SEEEEMPRE SOBRE TODAS AS PÁGINAS

import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? _entry;

  static bool _open = false;

  Loader._();

  static void show() {
    //! IGUAL AQUI É-----
    // if (_entry == null) {
    //   _entry = OverlayEntry(
    //     builder: (context) {},
    //   );
    // }
    //* IGUAL A ISTO ABAIXO
    _entry ??= OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black45,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    if (!_open) {
      _open = true;
      Asuka.addOverlay(_entry!);
    }
  }

  static void hide() {
    if (_open) {
      _open = false;
      _entry?.remove();
    }
  }
}
