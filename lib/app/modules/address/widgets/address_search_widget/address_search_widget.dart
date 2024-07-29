// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../address_page.dart';

typedef AddressSelectedCallBack = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallBack addressSelectedCallBack;

  const _AddressSearchWidget({required this.addressSelectedCallBack});

  // const _AddressSearchWidget({required this.searchResultCallBack});

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final controller = Modular.get<AddressSearchController>();

  final searchTextEC = TextEditingController();
  final searchTextFN = FocusNode();

  @override
  void dispose() {
    searchTextEC.dispose();
    searchTextFN.dispose();
    super.dispose();
  }

//!-------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceModel>(
      builder: _decoration,
      itemBuilder: _onItemBuilder,
      onSelected: _onSuggestionSelected,
      suggestionsCallback: _onSuggestionCallback,
    );
  }

//!-------------------------------------------
  Widget _decoration(context, controller, focusNode) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    );
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          focusedBorder: border,
          border: border,
          disabledBorder: border,
          enabledBorder: border,
          errorBorder: border,
          hintText: 'Insira endereço:',
        ),
      ),
    );
  }

  Widget _onItemBuilder(_, item) {
    // print('$item');
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(item.address),
    );
    // _ItemTile(address: item.address);
  }

  Future<List<PlaceModel>> _onSuggestionCallback(String pattern) async {
    if (pattern.isNotEmpty) {
      return controller.searchAddress(pattern);
    }
    return <PlaceModel>[];
  }

  void _onSuggestionSelected(PlaceModel sugestion) {
    searchTextEC.text = sugestion.address;
    widget.addressSelectedCallBack(sugestion);
  }
}

// ignore: unused_element
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
