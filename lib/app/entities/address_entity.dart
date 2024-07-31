import 'package:flutter/material.dart';

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// diferença entre entidade e modelo
//classe simples sem nada especial dentro, representação de algo, relacionado a uma tabela do BD

class AddressEntity {
  final int? id;
  final String address;
  final double lat;
  final String lng;
  final String aditional;

  AddressEntity({
    this.id,
    required this.address,
    required this.lat,
    required this.lng,
    required this.aditional,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'lat': lat,
      'lng': lng,
      'aditional': aditional,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      id: map['id'] != null ? map['id'] as int : null,
      address: (map['address'] ?? '') as String,
      lat: (map['lat'] ?? 0.0) as double,
      lng: (map['lng'] ?? '') as String,
      aditional: (map['aditional'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  AddressEntity copyWith({
    ValueGetter<int?>? id,
    String? address,
    double? lat,
    String? lng,
    String? aditional,
  }) {
    return AddressEntity(
      id: id != null ? id() : this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      aditional: aditional ?? this.aditional,
    );
  }
}
