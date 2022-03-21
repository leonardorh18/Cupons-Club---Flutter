import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/models/Usuario.dart';
import 'package:teste/views/home.dart';
import 'package:teste/views/login.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool carregando = true;
  verificaStatus() async{
    print('verificando');
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logado = prefs.getBool('logado');
    print('LOGADO ??');
    print(logado);
    if (logado is bool && logado == true){

          var nome =  prefs.getString('nome');
          var telefone = prefs.getString('telefone');
          var email = prefs.getString('email');
          var senha = prefs.getString('senha');
          var id = prefs.getString('id');
          Usuario usuario = Usuario(id, nome, email, telefone, senha);
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Home(usuario)));
    } else {
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Login()));
    }


  }
  @override  
  void initState()  {    
    verificaStatus();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.white,
        ),
      child: SpinKitHourGlass(
                      color: Colors.red,
                      size: 100.0,
        ),
      
    );
  }
}