import 'package:teste/DAO/Conn.dart';
import 'package:teste/models/Usuario.dart';

class UsuarioDAO {
  Conn _conn = Conn();

  Future<dynamic> login(String email, String senha) async {
    var dbconn = await this._conn.connectDB();
    try {
      var results = await dbconn.query(""" select * from usuario where email = '$email' and senha = '$senha' """);
      await dbconn.close();
      print('Encontrado: ' + results.length.toString());
      if (results.length > 0) {
        for (var row in results) {
          Usuario usuario = Usuario(row['id'], row['nome'], row['email'],
              row['telefone'], row['senha']);
          return usuario;
        }
      } else {
        return false;
      }
    } catch (e) {
      await dbconn.close();
      print("ERRO AO FAZER LOGIN" + e.toString());
      return false;
    }
  }

  Future<dynamic> checkBD(String email, String phone) async {
    var dbconn = await this._conn.connectDB();
    try {
      var results = await dbconn.query(""" select * from usuario where email = '$email' or telefone = '$phone' """);
      await dbconn.close();
      print('Encontrado: ' + results.length.toString());
      if (results.length >= 1) {
        // for (var row in results) {
        //   Usuario usuario = Usuario(row['id'], row['nome'], row['email'],
        //       row['telefone'], row['senha']);
          return false; //não pode criar
        //}
      } else {
        return true; //pode criar
      }
    } catch (e) {
      await dbconn.close();
      print("ERRO AO FAZER LOGIN " + e.toString());
      return false;
    }
  }
}
