import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:teste/views/cupons.dart';
import 'package:flutter/services.dart';
import 'package:teste/views/signin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> telas = [
    Cadastro(),
    ListCupons(),
    Container(child:Text('oi tela 3')),
  ];

  var indexTela = 0;

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
          value:SystemUiOverlayStyle(
          statusBarColor: Colors.red, //i like transaparent :-)
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:Brightness.dark, //navigation bar icons' color
    ), 
    child: Scaffold(
      appBar: AppBar(
        
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),

          title: Text('Nome do aplicativo'),

          actions: [
              Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.menu,
                  size: 26.0,
                ),
              )
            ),

      
          ],

          backgroundColor: Colors.red,
      ),

      body: telas[indexTela],

      bottomNavigationBar: SalomonBottomBar(
          currentIndex: indexTela,
          onTap: (i) => setState(() => indexTela = i),
          items: [

            SalomonBottomBarItem(
              icon: FaIcon(FontAwesomeIcons.ticketAlt),
              title: Text("Cupons"),
              selectedColor: Colors.red[400],
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Fidelidade"),
              selectedColor: Colors.pink,
            ),
              SalomonBottomBarItem(
              icon: FaIcon(FontAwesomeIcons.history),
              title: Text("Histórico"),
              selectedColor: Colors.pink,
            ),

          ]
      ),
      ),
    );
  }
}