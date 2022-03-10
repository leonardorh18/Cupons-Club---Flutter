import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:teste/views/cupons.dart';
import 'package:teste/views/widgets/appbar.dart';
import 'package:flutter/services.dart';
import 'package:teste/views/signin.dart';
import 'package:teste/models/Usuario.dart';

class Home extends StatefulWidget {
  Usuario usuario;
  Home(this.usuario);

class _HomeState extends State<Home> {
  var indexTela = 1;
  CustomAppBar appBar = new CustomAppBar();

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
    Container(child:Text('oi tela 2')),
    ListCupons(widget.usuario),
    Container(child:Text('oi tela 3')),
  ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
          value:SystemUiOverlayStyle(
          statusBarColor: Colors.red, //i like transaparent :-)
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:Brightness.dark, //navigation bar icons' color
    ), 
    child: Scaffold(
      appBar: appBar.buildAppBar() ,

      body: telas[indexTela],

      bottomNavigationBar: SalomonBottomBar(
          currentIndex: indexTela,
          onTap: (i) => setState(() => indexTela = i),
          items: [


            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Fidelidade"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: FaIcon(FontAwesomeIcons.ticketAlt),
              title: Text("Cupons"),
              selectedColor: Colors.red[400],
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