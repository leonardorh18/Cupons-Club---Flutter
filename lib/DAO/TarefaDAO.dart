


import 'package:teste/DAO/Conn.dart';
import 'package:teste/models/Tarefa.dart';

class TarefaDAO{

  Conn _conn = Conn();

  Future< List<Tarefa> > getTarefasByCupomId(var cupom_id) async {
    var dbconn = await this._conn.connectDB(); 
    try {
      List<Tarefa> listaTarefas = [];
      var result= await dbconn.query(""" select * from tarefa where fk_cupom_id = ${cupom_id} """);
      
      for (var row in result){

        listaTarefas.add( new Tarefa(row['descricao'], row['id']));

      }
      await dbconn.close();
      return listaTarefas;

    } catch (e){

      await dbconn.close();
      print("ERRO AO BUSCAR TAREFA");
      throw Exception(e.toString());

    }

  }
}