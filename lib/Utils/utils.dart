import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Utils {

    loading(context) {
  
      showDialog(
              context: context,
              builder: (BuildContext context){
                  return SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    );
              }
          );
  
  }
}