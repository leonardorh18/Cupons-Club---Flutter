
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/views/login.dart';
class CustomAppBar {

 AppBar buildAppBar (context){

     return AppBar(
        
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),

          title: Text('Cupãozin'),

          actions: [
            PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int> (
                  value: 1,
                  child: Text('Minha conta')
                ),

                PopupMenuItem<int> (
                  value: 0,
                  child: Text('Sair')
                )
              ])
      
          ],

          backgroundColor: Colors.red,
      );

  }
  onSelected(context, item) async{
    switch(item){
      case 0:
      //deletar variavel logada aqui
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
         Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Login()));
    }

  }
}