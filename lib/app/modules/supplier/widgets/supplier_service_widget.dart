import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("BANHO"),
      subtitle: const Text(r"R$ 10,00"),
      leading: CircleAvatar(
        backgroundColor: context.primaryColor,
        child: const Icon(
          Icons.pets,
          color: Colors.black,
        ),
      ),
      trailing: Icon(Icons.add_circle, color: context.primaryColor, size: 30),
      // trailing: const Icon(Icons.remove_circle, color: Colors.red, size:30),
    );
  }
}
