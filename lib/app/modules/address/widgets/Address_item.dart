// ignore: file_names

part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  final String address;
  final String additional;
  final VoidCallback onTap;

  const _AddressItem({
    required this.address,
    required this.additional,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child:  ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(address),
        subtitle: Text(additional),
      ),
    );
  }
}
