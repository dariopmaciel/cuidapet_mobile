import 'dart:convert';

// import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// diferença entre entidade e modelo
//classe simples sem nada especial dentro, representação de algo, relacionado a uma tabela do BD

class AddressEntity {
  final int? id;
  final String address;
  final double lat;
  final double lng;
  final String additional;
  AddressEntity({
    this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.additional,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'lat': lat,
      'lng': lng,
      'additional': additional,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id'] != null ? map['id'] as int : null,
      address: (map['address'] ?? '') as String,
      lat: double.parse(map['lat'] ?? 0.0),
      lng: double.parse(map['lng'] ?? ''),
      additional: (map['additional'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  

  AddressEntity copyWith({
    int? id,
    String? address,
    double? lat,
    double? lng,
    String? additional,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      additional: additional ?? this.additional,
    );
  }
}
