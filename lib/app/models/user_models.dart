import 'dart:convert';

class UserModels {
  final String email;
  final String registerType;
  final String imgAvatar;

  UserModels({
    required this.email,
    required this.registerType,
    required this.imgAvatar,
  });

//ESTRATÉGIA CRIADA PARA DESLOGAR
//Onde é passado item vazios para deslogar pois não podem ser NULOS
  UserModels.empty()
      : email = '',
        registerType = '',
        imgAvatar = '';

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'registerType': registerType,
      'imgAvatar': imgAvatar,
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
      email: map['email'] ?? '',
      registerType: map['registerType'] ?? '',
      imgAvatar: map['imgAvatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(json.decode(source));
}
