import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './social_repository.dart';

class SocialRepositoryImpl extends SocialRepository {
  @override
  Future<SocialNetworkModel> facebookLogin() {
    // TODO: implement facebookLogin
    throw UnimplementedError();
  }

  @override
  Future<SocialNetworkModel> googleLogin() async {
    //pedimos instancia do googlesingin
    final googleSingIn = GoogleSignIn();
    //caso ja esteja conectado
    if (await googleSingIn.isSignedIn()) {
      //será desconectado e será preciso conectar novamente, não pegando da memoria
      await googleSingIn.disconnect();
    }
    //será pedido o login guardando dentro de googleUser o usuário logado
    final googleUser = await googleSingIn.signIn();
    //se tudo deu certo será guardado dentro de googleAuth o googleUser + sua Autenticação (dentro desta autenticação se busca os dados/info para montar modelo). E estará preenchido
    final googleAuth = await googleUser?.authentication;
    //se não for nulo nenhuma das opções será montado o objeto de modelo
    if (googleAuth != null && googleUser != null) {
      return SocialNetworkModel(
        id: googleAuth.idToken ?? '',
        nome: googleUser.displayName ?? '',
        email: googleUser.email,
        type: 'Google',
        avatar: googleUser.photoUrl,
        accessToken: googleAuth.accessToken ?? '',
      );
    } else { //se algum deles for nulo retorna a msg abaixo
      throw Failure(message: "Erro ao realizar login com o Google");
    }
  }
}
