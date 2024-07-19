part of '../address_page.dart';

class _AddressSearchWidget extends StatefulWidget {
  const _AddressSearchWidget({super.key});

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      builder: _decoration,
      itemBuilder: _onItemBuilder,
      onSelected: _onSuggestionSelected,
      suggestionsCallback: _onSuggestionCallback,
    );
  }

//-------------------------------------------
  Widget _decoration(context, controller, focusNode) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: border,
        disabledBorder: border,
        enabledBorder: border,
        hintText: 'Insira endereço:',
      ),
    );
  }

  Widget _onItemBuilder(_, item) {
    print('$item');
    return _ItemTile(
      address: item.address,
    );
  }

  FutureOr<List<PlaceModel>?> _onSuggestionCallback(String pattern) {
    print("Endereço digitado: $pattern");
    return [
      PlaceModel(address: 'Av Paulista, 200', lat: 123.0, lng: 456.0),
      PlaceModel(address: 'Av Paulista, 500', lat: 123.0, lng: 456.0),
      PlaceModel(address: 'Av Paulista, 1200', lat: 123.0, lng: 456.0),
    ];
  }

  void _onSuggestionSelected(PlaceModel sugestion) {
    print(sugestion);
  }
}

class _ItemTile extends StatelessWidget {
  final String address;

  const _ItemTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
