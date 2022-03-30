import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/DAO/CupomDAO.dart';
import 'package:teste/Utils/utils.dart';
import 'package:teste/models/Cupom.dart';
import 'package:teste/models/Tarefa.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CupomDialog{
  Utils utils = Utils();
    final spinkit = SpinKitFoldingCube(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    );
  },
);
  CupomDAO cupomDAO = CupomDAO();
  pegarCupom(Cupom cupom, String id, update, context) async{

  
        showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Você deseja resgatar este cupom?"),
                    content: Text("Você realmente deseja resgatar este cupom? Cumpra as Tarefas!"),
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
                        utils.loading(context);
                        var res = await cupomDAO.pegarCupom(cupom, id);
                        Navigator.of(context).pop();
                        if (res){
                              Fluttertoast.showToast(
                                  msg: "Cupom resgatado!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              update(true);
                        }else{
                                   Fluttertoast.showToast(
                                  msg: "Não foi possível resgatar o cupom :(",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                        }
                        Navigator.of(context).pop();
                        

                          },
                      ),
                    ],
                  )
                  ;
              }
          );

}
}