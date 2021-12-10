

import 'package:teste/DAO/Conn.dart';
import 'package:teste/models/Estabelecimento.dart';

class EstabelecimentoDAO {

  Conn _conn = Conn();

  getEstabelecimentoById(var id) async {
     var dbconn = await this._conn.connectDB(); 
    try {

      var result_est = await dbconn.query(""" select * from estabelecimento where id = ${id} """);
      
      Estabelecimento estabelecimento = Estabelecimento();

      for (var row_est in result_est){
        
        estabelecimento = new Estabelecimento(
          bairro: row_est['bairro'],
          numero: row_est['numero'],
          rua: row_est['rua'],
          cep: row_est['cep'],
          cidade: row_est['cidade'],
          estado: row_est['estado'],
          nome: row_est['nome'],
          email: row_est['email'],
          id: row_est['id'],
          telefone: row_est['telefone']);

      }
    
    await dbconn.close();
    return estabelecimento;

    } catch (e){

      await dbconn.close();
      print("ERRO AO BUSCAR ESTABELECIMENTO");
      throw Exception(e.toString());

    }

  }

}