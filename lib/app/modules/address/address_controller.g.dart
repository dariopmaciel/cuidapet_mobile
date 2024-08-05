// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressController on AddressControllerBase, Store {
  late final _$_addressAtom =
      Atom(name: 'AddressControllerBase._address', context: context);

  List<AddressEntity> get address {
    _$_addressAtom.reportRead();
    return super._address;
  }

  @override
  List<AddressEntity> get _address => address;

  @override
  set _address(List<AddressEntity> value) {
    _$_addressAtom.reportWrite(value, super._address, () {
      super._address = value;
    });
  }

  late final _$_locationServiceInavailableAtom = Atom(
      name: 'AddressControllerBase._locationServiceInavailable',
      context: context);

  bool get locationServiceInavailable {
    _$_locationServiceInavailableAtom.reportRead();
    return super._locationServiceInavailable;
  }

  @override
  bool get _locationServiceInavailable => locationServiceInavailable;

  @override
  set _locationServiceInavailable(bool value) {
    _$_locationServiceInavailableAtom
        .reportWrite(value, super._locationServiceInavailable, () {
      super._locationServiceInavailable = value;
    });
  }

  late final _$_locationPermitionAtom =
      Atom(name: 'AddressControllerBase._locationPermition', context: context);

  LocationPermission? get locationPermition {
    _$_locationPermitionAtom.reportRead();
    return super._locationPermition;
  }

  @override
  LocationPermission? get _locationPermition => locationPermition;

  @override
  set _locationPermition(LocationPermission? value) {
    _$_locationPermitionAtom.reportWrite(value, super._locationPermition, () {
      super._locationPermition = value;
    });
  }

  late final _$_placemodelAtom =
      Atom(name: 'AddressControllerBase._placemodel', context: context);

  PlaceModel? get placemodel {
    _$_placemodelAtom.reportRead();
    return super._placemodel;
  }

  @override
  PlaceModel? get _placemodel => placemodel;

  @override
  set _placemodel(PlaceModel? value) {
    _$_placemodelAtom.reportWrite(value, super._placemodel, () {
      super._placemodel = value;
    });
  }

  late final _$getAddressesAsyncAction =
      AsyncAction('AddressControllerBase.getAddresses', context: context);

  @override
  Future<void> getAddresses() {
    return _$getAddressesAsyncAction.run(() => super.getAddresses());
  }

  late final _$myLocationAsyncAction =
      AsyncAction('AddressControllerBase.myLocation', context: context);

  @override
  Future<void> myLocation() {
    return _$myLocationAsyncAction.run(() => super.myLocation());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
