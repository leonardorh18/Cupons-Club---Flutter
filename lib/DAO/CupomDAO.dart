
import 'package:teste/DAO/Conn.dart';
import 'package:teste/DAO/EstabelecimentoDAO.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Estabelecimento.dart';
import 'package:intl/intl.dart';

class CupomDAO {

  Conn _conn = Conn();
  Future <bool> pegarCupom(Cupom cupom, String idUsuario) async {
            var dbconn = await this._conn.connectDB(); 
            try {

            
                var now = new DateTime.now();
                var formatter = new DateFormat('yyyy-MM-dd');
                String formattedDate = formatter.format(now);
                print(formattedDate);
                  var result = await dbconn.query(""" 
                  insert into cupons_usados 
                  (fk_cupom_id, fk_usuario_id, data_pego, status_cupom, qr_code)
                  values
                  (${cupom.id.toString()}, ${idUsuario}, '${formattedDate}', 1, 'codigo aqui')
                  """ );
                  await dbconn.query('update cupom set contagem_cupons = contagem_cupons - 1 where id = ${cupom.id.toString()};');
                  await dbconn.close();
                
                  return true;
            } catch (e) {
                await  dbconn.close();
                print("ERRO pegar CUPON");
                return false;
                

            }


    }
    Future<bool> cupomResgatado(idCupom, idUser) async{
        var dbconn = await this._conn.connectDB(); 
        try{

           var result = await dbconn.query("select * from cupons_usados where fk_cupom_id = $idCupom and fk_usuario_id = $idUser ");
            await  dbconn.close();
           if (result.length > 0){
             return true;
           } else {
             return false;

           }
         

        }catch(e){
          await  dbconn.close();
          print("ERRO AO VERIFICAR RESGATE"+e.toString());
          return false;
        }

      
    }

    getCuponsUser(userId) async {

       var dbconn = await this._conn.connectDB(); 


    List <Cupom> listaCupons = [];

    try {
        var result = await dbconn.query("""select DISTINCT 
          r.id as est_id, r.email as email, r.nome as nome, r.rua as rua, r.bairro as bairro,
          r.cidade as cidade, r.cep as cep, r.estado as estado, r.telefone as telefone, 
          r.numero as numero,
          c.id as cupom_id,  data_criacao,
          data_termino, descricao, porcentagem_desconto, 
          preco_do_produto, nome_produto, contagem_cupons,
          link_imagem from cupom c inner join estabelecimento r on r.id = c.fk_estabelecimento_id
          where c.id in (select fk_cupom_id from cupons_usados where fk_usuario_id = $userId)
         """);

        for (var row in result){

          var est_id = row['est_id'];
          var cupom_id = row['cupom_id'];
          //print("EST ID" + est_id.toString());

          Cupom cupom = new Cupom(
                row['cupom_id'], row['data_criacao'], row['contagem_cupons'],
                row['data_termino'], row['descricao'], row['nome_produto'], row['porcentagem_desconto'],
                row['preco_do_produto'], row['link_imagem']
          );

           cupom.estabelecimento = new Estabelecimento(
                    bairro: row['bairro'],
                    numero: row['numero'],
                    rua: row['rua'],
                    cep: row['cep'],
                    cidade: row['cidade'],
                    estado: row['estado'],
                    nome: row['nome'],
                    email:row['email'],
                    id: row['id'],
                    telefone: row['telefone']);

        //TarefaDAO tarefaDAO = TarefaDAO();
        //cupom.setListaTarefas = await tarefaDAO.getTarefasByCupomId(cupom_id.toString());

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


  getCupons() async{

    var dbconn = await this._conn.connectDB(); 


    List <Cupom> listaCupons = [];

    try {
        var result = await dbconn.query("""select 
          r.id as est_id, r.email as email, r.nome as nome, r.rua as rua, r.bairro as bairro,
          r.cidade as cidade, r.cep as cep, r.estado as estado, r.telefone as telefone, 
          r.numero as numero,
          c.id as cupom_id,  data_criacao,
          data_termino, descricao, porcentagem_desconto, 
          preco_do_produto, nome_produto, contagem_cupons,
          link_imagem from cupom c  inner join estabelecimento r on r.id = c.fk_estabelecimento_id""");

        for (var row in result){

          var est_id = row['est_id'];
          var cupom_id = row['cupom_id'];
          //print("EST ID" + est_id.toString());

          Cupom cupom = new Cupom(
                row['cupom_id'], row['data_criacao'], row['contagem_cupons'],
                row['data_termino'], row['descricao'], row['nome_produto'], row['porcentagem_desconto'],
                row['preco_do_produto'], row['link_imagem']
          );

           cupom.estabelecimento = new Estabelecimento(
                    bairro: row['bairro'],
                    numero: row['numero'],
                    rua: row['rua'],
                    cep: row['cep'],
                    cidade: row['cidade'],
                    estado: row['estado'],
                    nome: row['nome'],
                    email:row['email'],
                    id: row['id'],
                    telefone: row['telefone']);

        //TarefaDAO tarefaDAO = TarefaDAO();
        //cupom.setListaTarefas = await tarefaDAO.getTarefasByCupomId(cupom_id.toString());

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