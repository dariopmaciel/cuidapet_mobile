import 'dart:convert';

class ConfirmLoginModel {
  final String accessToken;
  final String refreshToken;
  
  
  ConfirmLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_Token': accessToken,
      'refresh_Token': refreshToken,
    };
  }

  factory ConfirmLoginModel.fromMap(Map<String, dynamic> map) {
    return ConfirmLoginModel(
      accessToken: map['access_Token'] ?? '',
      refreshToken: map['refresh_Token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmLoginModel.fromJson(String source) => ConfirmLoginModel.fromMap(json.decode(source));
}
