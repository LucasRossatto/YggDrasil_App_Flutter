
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class UsuarioRepositorio {
  final ApiService _api = ApiService();

  Future<UsuarioModel> cadastrarUsuario(String nome, String email, String senha) async {
    final data = await _api.post("/CadastrarUsuario", {
      "nome": nome,
      "email": email,
      "senha": senha,
    });
    return UsuarioModel.fromJson(data);
  }

  Future<UsuarioModel> login(String email, String senha) async {
    final encodedEmail = Uri.encodeComponent(email);
    final encodedSenha = Uri.encodeComponent(senha);
    final data = await _api.get("/GetLogin/$encodedEmail,$encodedSenha");
    return UsuarioModel.fromJson(data);
  }
}
