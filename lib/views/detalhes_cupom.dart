
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/DAO/CupomDAO.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/Utils/utils.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Tarefa.dart';
import 'package:teste/models/Usuario.dart';
import 'package:teste/views/widgets/appbar.dart';
import 'package:teste/views/widgets/cupom_dialog.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
class DetalhesCupom extends StatefulWidget {
  
 Cupom cupom;
 Usuario usuario;
 DetalhesCupom(this.cupom, this.usuario);
  @override
  State<DetalhesCupom> createState() => _DetalhesCupomState();
}

class _DetalhesCupomState extends State<DetalhesCupom> {
  CustomAppBar appBar = new CustomAppBar();
  bool carregandoTarefas = true;
  bool resgatado = false;
  Utils utils = Utils();
  TarefaDAO tarefaDAO = TarefaDAO();
  CupomDAO cupomDAO = CupomDAO();
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
  void resgatadoState(bool value){
    setState(() {
      resgatado = value;
    });
  }
  void buscarTarefas(cupom) async{

    cupom.setListaTarefas = await tarefaDAO.getTarefasByCupomId(cupom.id.toString());
    resgatado = await cupomDAO.cupomResgatado(cupom.id.toString(), widget.usuario.getId.toString());
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
      appBar:appBar.buildAppBar(context),
      body: SingleChildScrollView(child: Padding( 
          padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Column(
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
                            style: GoogleFonts.montserratAlternates(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))
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

                        Expanded(
                          child:InkWell(
                          onTap: () async {
                            await utils.openMap(-34.123, -19.3092);
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("""${widget.cupom.estabelecimento.rua.toString()} ${widget.cupom.estabelecimento.numero.toString()}, ${widget.cupom.estabelecimento.numero.toString()}, ${widget.cupom.estabelecimento.bairro}, ${widget.cupom.estabelecimento.cidade}""",
                                style: GoogleFonts.montserratAlternates(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
                              ),
                          )
                        )

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

                          Expanded(child: 
                          InkWell(
                          onTap: () async {
                            await utils.openPhone(widget.cupom.estabelecimento.telefone.toString());
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                              child: Text('${widget.cupom.estabelecimento.telefone}',
                                style: GoogleFonts.montserratAlternates(fontSize:16, fontWeight: FontWeight.w500, color: Colors.black))
                          ),
                        )
                        )

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
                            style: GoogleFonts.montserratAlternates(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
                        ),)

                        ],
                      ),
                      //------------ DESCRICAO
                    SizedBox(height: 25,),

                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Cupom válido para:',
                            style: GoogleFonts.montserratAlternates(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black))
                        ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(15,10,0,0),
                      child:   Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${widget.cupom.nome_produto.toString()}',
                            style: GoogleFonts.comfortaa(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black))
                            )
                          
                        ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                        width: 170,
                        child:Divider(
                            color: Colors.black,
                            thickness: 1
                        )
                      )
                    ),  
                   Padding(
                      padding:  EdgeInsets.fromLTRB(15,10,0,0),
                      child:  Align(
                          alignment: Alignment.centerLeft,
                          child: Text('De R\$ ${widget.cupom.preco} por R\$ '+ (widget.cupom.preco * (1 - (widget.cupom.porc_desconto/100))).toStringAsFixed(2) + ' com ${widget.cupom.porc_desconto.toString()}% de desconto',
                            style: GoogleFonts.comfortaa(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.redAccent[700])
                            )
                          )
                        
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                        width: 170,
                        child:Divider(
                            color: Colors.black,
                            thickness: 1
                        )
                      )
                    ), 
                    Padding(
                      padding:  EdgeInsets.fromLTRB(15,10,0,0),
                      child: Text(widget.cupom.descricao.toString(),
                       style: GoogleFonts.comfortaa(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black)),
                    ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                        width: 170,
                        child:Divider(
                            color: Colors.black,
                            thickness: 1
                        )
                      )
                    ),  
                  // ------------------- TAREFAS
                    SizedBox(height: 25,),
                    Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Conclua as tarefas para resgatar o cupom:',
                            style: GoogleFonts.montserratAlternates(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))
                        ),  
                        SizedBox(height: 10,),
                      
                      
                      ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          itemCount: widget.cupom.getListaTarefas.length,
                          itemBuilder: (context, index){

                            Tarefa tarefa = widget.cupom.getListaTarefas[index];

                            return Padding(
                            padding:  EdgeInsets.fromLTRB(15,10,0,0),
                            child:  Text('* ' +tarefa.getDescricao.toString(),
                              style: GoogleFonts.comfortaa(fontSize: 15, color: Colors.black)),
                            );
                          }

                        
                      
                    ),

                     SizedBox(height: 40,),
                resgatado? Text('Cupom ja foi resgatado!'):ElevatedButton(
                          child: Text('Resgatar Cupom'),
                          onPressed: () async {
                            await cupomDialog.pegarCupom(widget.cupom, widget.usuario.getId.toString(), resgatadoState, context);
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
    )
    )
    ;
  }
}