
import 'package:teste/DAO/Conn.dart';
import 'package:teste/DAO/EstabelecimentoDAO.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Estabelecimento.dart';

class CupomDAO {

  Conn _conn = Conn();

  getCupons() async{

    var dbconn = await this._conn.connectDB(); 
    List <Cupom> listaCupons = [];

    try {
        var result = await dbconn.query("""select c.id as cupom_id, r.id as est_id, data_criacao,
          data_termino, descricao, porcentagem_desconto, 
          preco_do_produto, nome_produto, contagem_cupons,
          link_imagem from cupom c  inner join estabelecimento r on r.id = c.fk_estabelecimento_id""");

        for (var row in result){

          var est_id = row['est_id'];
          var cupom_id = row['cupom_id'];
          print("EST ID" + est_id.toString());

          Cupom cupom = new Cupom(
                row['cupom_id'], row['data_criacao'], row['contagem_cupons'],
                row['data_termino'], row['descricao'], row['nome_produto'], row['porcentagem_desconto'],
                row['preco_do_produto'], row['link_imagem']
          );

         EstabelecimentoDAO estDao = EstabelecimentoDAO();
          TarefaDAO tarefaDAO = TarefaDAO();
           
          cupom.estabelecimento = await estDao.getEstabelecimentoById(est_id.toString());

          cupom.setListaTarefas = await tarefaDAO.getTarefasByCupomId(cupom_id.toString());

          listaCupons.add(cupom);

        }

      //print("TAMHNOOOOOOO "+ listaCupons.length.toString());
      await  dbconn.close();
      return listaCupons;

    } catch (e) {
      await  dbconn.close();
      print("ERRO BUSCAR CUPONS");
      throw Exception(e.toString());

    }



  }
}