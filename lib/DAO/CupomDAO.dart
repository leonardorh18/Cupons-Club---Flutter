
import 'package:teste/DAO/Conn.dart';
import 'package:teste/models/Cupom.dart';

class CupomDAO {

  Conn _conn = Conn();

  getCupons() async{

    var dbconn = await this._conn.connectDB(); 
    List <Cupom> listaCupons = [];

    if (dbconn != null) {
        var result = await dbconn.query("""select r.nome as est_nome, r.id as est_id, c.id as cupom_id, data_criacao,
          data_termino, descricao, porcentagem_desconto, 
          preco_do_produto, nome_produto, contagem_cupons,
          link_imagem from cupom c  inner join estabelecimento r on r.id = c.fk_estabelecimento_id""");

        for (var row in result){
          print(row);
          listaCupons.add(new Cupom(
                row['cupom_id'], row['data_criacao'], row['contagem_cupons'],
                row['data_termino'], row['descricao'], row['est_id'],
                row['est_nome'], row['nome_produto'], row['porcentagem_desconto'],
                row['preco_do_produto'], row['link_imagem']
          ));
        }
      print("TAMHNOOOOOOO "+ listaCupons.length.toString());
      await  dbconn.close();
      return listaCupons;

    } else {
      await  dbconn.close();
      print("ERRO AO SE CONECTAR");

    }



  }
}