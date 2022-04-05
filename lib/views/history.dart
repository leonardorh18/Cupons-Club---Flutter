import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/DAO/CupomDAO.dart';
import 'package:teste/DAO/TarefaDAO.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/Utils/utils.dart';
import 'package:teste/models/Tarefa.dart';
import 'package:teste/views/detalhes_cupom.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teste/models/Usuario.dart';

class History extends StatefulWidget {
  Usuario usuario;
  History(this.usuario);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Cupom> listaCupons = [];
  Utils utils = Utils();
  CupomDAO cupomDAO = CupomDAO();
  bool carregando = true;
  TarefaDAO tarefaDAO = TarefaDAO();
  double total = 0;
  double eco = 0;
  double economizou = 0;
  final spinkit = SpinKitWanderingCubes(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      );
    },
  );

  buscarCupons() async {
    listaCupons = await cupomDAO.getCuponsUser(widget.usuario.getId.toString());
    //print('TAMANHO '+ listaCupons.length.toString());
    for (Cupom cupom in listaCupons){
      setState(() {
    
      eco = eco + cupom.preco *(1 -(cupom.porc_desconto / 100));
      total = total + cupom.preco;
      
      });

    }
    setState(() {
      economizou = total - eco;
      carregando = false;
    });
  }

  @override
  void initState() {
    buscarCupons();
    super.initState();
  }

  Widget build(BuildContext context) {
    return carregando
        ? spinkit
        : Container(
            child: Column(
              children: [
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 18, 10, 3),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Histórico',
                              style: GoogleFonts.montserrat(
                                  fontSize: 25, color: Colors.black))),
                    ),
                     Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 10, 3),
                      child:Align(
                          alignment: Alignment.topLeft,
                          child: Text('Você já gastou R\$ ${eco.toStringAsFixed(2)}, economia de R\$ ${economizou.toStringAsFixed(2)}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13, color: Colors.black)))),
                  ],
                )),
                Flexible(
                    child: ListView.builder(
                        itemCount: listaCupons.length,
                        itemBuilder: (context, index) {
                          Cupom cupom = listaCupons[index];
                          return Card(
                              color: Color(0xEAE8E8),
                              // elevation: 1,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeftWithFade,
                                          child: DetalhesCupom(
                                              cupom, widget.usuario)));
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: ClipRect(
                                              child: Image.network(
                                                cupom.link_imagem.toString(),
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          SizedBox(height: 5,),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  cupom.estabelecimento.nome
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black))),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  '${cupom.estabelecimento.rua} - ${cupom.estabelecimento.numero}, ${cupom.estabelecimento.bairro} - 0.0km',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors
                                                          .black) //TextStyle( color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),),
                                                  )),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Align(
                                            alignment: Alignment.centerRight,
                                            child:Text('${cupom.nome_produto} - ${cupom.porc_desconto.toInt()}% off de R\$ ${cupom.preco} por R\$'+ (cupom.preco * (1 - (cupom.porc_desconto/100))).toStringAsFixed(2),
                                              style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black))
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              FaIcon(FontAwesomeIcons.clock, size: 15, color: Colors.yellow),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                 'Disponível até '+cupom.data_termino.toString().split(' ')[0] ,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 10,)
                                        ],
                                      )),
                                      SizedBox(
                                        width: 5,
                                       
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }))
              ],
            ),
          );
  }
}
