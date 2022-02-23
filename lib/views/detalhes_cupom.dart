
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Tarefa.dart';
import 'package:teste/views/widgets/appbar.dart';
import 'package:teste/views/widgets/cupom_dialog.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
class DetalhesCupom extends StatefulWidget {
  
 Cupom cupom;
 DetalhesCupom(this.cupom);
  @override
  State<DetalhesCupom> createState() => _DetalhesCupomState();
}

class _DetalhesCupomState extends State<DetalhesCupom> {
  CustomAppBar appBar = new CustomAppBar();
  bool carregandoTarefas = true;
  TarefaDAO tarefaDAO = TarefaDAO();
  CupomDialog cupomDialog = CupomDialog();
    final spinkit = SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        );
      },
    );
  void buscarTarefas(cupom) async{

    cupom.setListaTarefas = await tarefaDAO.getTarefasByCupomId(cupom.id.toString());
    setState((){
      carregandoTarefas = false;
    });
  }
  @override  
  void initState()  {    
    buscarTarefas(widget.cupom); 
    super.initState();
  }
  Widget build(BuildContext context) {
    return carregandoTarefas ? spinkit : Scaffold(
      appBar:appBar.buildAppBar(),
      body: Padding( 
          padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
          child:Column(
                      children: [
                      // ------------------------- NOME
                      Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.store, size: 20, color: Colors.red)
                          ),
                        Expanded(child:Align(
                          alignment: Alignment.centerLeft,
                          child:Text(widget.cupom.estabelecimento.nome.toString(),
                            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))
                        ),)

                        ],
                      ),
                    SizedBox(height: 10,),
                    // ---------------- ENDERECO
                    Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.locationArrow, size: 20, color: Colors.blue)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("""${widget.cupom.estabelecimento.rua.toString()} ${widget.cupom.estabelecimento.numero.toString()}, ${widget.cupom.estabelecimento.numero.toString()}, ${widget.cupom.estabelecimento.bairro}, ${widget.cupom.estabelecimento.cidade}""",
                            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      SizedBox(height: 10,),
                      //------------------------CONTATOS
                      Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:FaIcon(FontAwesomeIcons.phone, size: 20, color: Colors.green)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${widget.cupom.estabelecimento.telefone}',
                            style: GoogleFonts.montserrat(fontSize:16, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      SizedBox(height: 10,),
                       Row(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:Icon(Icons.email, size: 20,)
                          ),
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${widget.cupom.estabelecimento.email}',
                            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      //------------ DESCRICAO
                    SizedBox(height: 25,),

                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Cupom válido para:',
                            style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
                        ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(15,10,0,0),
                      child: Text(widget.cupom.descricao.toString()),
                    ),
                    SizedBox(height: 25,),
                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Tarefas:',
                            style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))
                        ),  
                        SizedBox(height: 10,),
                      
                      
                      Flexible(
                        child: ListView.builder(
                          itemCount: widget.cupom.getListaTarefas.length,
                          itemBuilder: (context, index){

                            Tarefa tarefa = widget.cupom.getListaTarefas[index];

                            return Padding(
                            padding:  EdgeInsets.fromLTRB(15,10,0,0),
                            child:  Text(tarefa.getDescricao.toString()),
                            );
                          }

                        
                      ),
                    ),

                     SizedBox(height: 10,),
                ElevatedButton(
                          child: Text('Resgatar Cupom'),
                          onPressed: (){
                            cupomDialog.pegarCupom(widget.cupom, context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              textStyle:
                                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      
                      ],
                    ),
      )
    );
  }
}