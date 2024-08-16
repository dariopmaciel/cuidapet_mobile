import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
/*
{
    "id": 2,
    "name": "CLINICA VETERINARIA ATILIO",
    "logo": "https://picsum.photos/seed/0.24412205558654113/300",
    "address": "Rua Professor Atilio Innocenti",
    "phone": "11222222222",
    "latitude": -23.5897641,
    "longitude": -46.6804323,
    "category": {
        "id": 1,
        "name": "Petshop",
        "type": "P"
    }
}
 
  class SupplierCategoryModel {
  int id;
  String name;
  String type;
 
 */

import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';

class SupplierModel {
  final int id;
  final String name;
  final String logo;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;
  final SupplierCategoryModel category;

  SupplierModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'category': category.toMap(),
    };
  }

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      logo: (map['logo'] ?? '') as String,
      address: (map['address'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      latitude: (map['latitude'] ?? 0.0) as double,
      longitude: (map['longitude'] ?? 0.0) as double,
      category: SupplierCategoryModel.fromMap(
          map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
