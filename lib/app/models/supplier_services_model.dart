import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SupplierServicesModel {
  final int id;
  final int supplierId;
  final String name;
  final double price;

  SupplierServicesModel({
    required this.id,
    required this.supplierId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'supplierId': supplierId,
      'name': name,
      'price': price,
    };
  }

  factory SupplierServicesModel.fromMap(Map<String, dynamic> map) {
    return SupplierServicesModel(
      id: (map['id'] ?? 0) as int,
      supplierId: (map['supplierId'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      price: (map['price'] ?? 0.0) as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierServicesModel.fromJson(String source) =>
      SupplierServicesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
