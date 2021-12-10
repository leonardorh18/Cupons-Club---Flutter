import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Tarefa.dart';

class CupomDialog{

  detalheCupom(Cupom cupom, context) async{

    TarefaDAO tarefaDAO = TarefaDAO();
    
    List<Tarefa> listaTarefas = await  tarefaDAO.getTarefasByCupomId(cupom.id); 
    Navigator.of(context).pop();
        showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Detalhes do cupom"),
                    content: Expanded(child: Column(
                      children: [
                      // ------------------------- NOME
                      Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.store, size: 15, color: Colors.red)
                          ),
                        Expanded(child:Align(
                          alignment: Alignment.centerLeft,
                          child:Text(cupom.estabelecimento.nome.toString(),
                            style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black))
                        ),)

                        ],
                      ),
                    SizedBox(height: 10,),
                    // ---------------- ENDERECO
                    Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.locationArrow, size: 15, color: Colors.blue)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("""${cupom.estabelecimento.rua.toString()} ${cupom.estabelecimento.numero.toString()}, ${cupom.estabelecimento.numero.toString()}, ${cupom.estabelecimento.bairro}, ${cupom.estabelecimento.cidade}""",
                            style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      SizedBox(height: 10,),
                      //------------------------CONTATOS
                      Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.phone, size: 15, color: Colors.green)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${cupom.estabelecimento.telefone}',
                            style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      SizedBox(height: 10,),
                       Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:Icon(Icons.email, size: 15,)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${cupom.estabelecimento.email}',
                            style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      //------------ DESCRICAO
                    SizedBox(height: 15,),

                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Cupom válido para:',
                            style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black))
                        ),
                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Tarefas:',
                            style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black))
                        ),
                      

                        
                      ],
                    )),
                    actions:[
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Pegar cupom!"),
                        onPressed: () async{

                        Navigator.of(context).pop();
                        //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child:));

                          },
                      ),
                    ],
                  )
                  ;
              }
          );

}
}