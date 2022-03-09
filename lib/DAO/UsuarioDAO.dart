


import 'package:teste/DAO/Conn.dart';
import 'package:teste/models/Usuario.dart';

class UsuarioDAO{

  Conn _conn = Conn();

  Future <dynamic> login(String email, String senha) async {
     var dbconn = await this._conn.connectDB(); 
    try {
    var results = await dbconn.query(""" select * from usuario where email = '$email' and senha = '$senha' """);
     await dbconn.close();
     print('Encontrad0: ' + results.length.toString());
     if(results.length > 0){
       for (var row in results){
         Usuario usuario = Usuario(row['id'], row['nome'], row['email'], row['telefone'], row['senha']);
         return usuario;
       }
     } else {
       return false;
     }
  

    } catch (e){
      await dbconn.close();
      print("ERRO AO FAZER LOGIN" + e.toString());
      return false;
    }

    
  }
}