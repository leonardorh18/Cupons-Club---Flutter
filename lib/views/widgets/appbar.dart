
import 'package:flutter/material.dart';
class CustomAppBar {

 AppBar buildAppBar (){
   return AppBar(
        
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
      );

  }
}