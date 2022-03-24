import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  loading(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitHourGlass(
            color: Colors.red,
            size: 50.0,
          );
        });
  }

  showMessageUp(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIos: 10,
        fontSize: 16.0);
  }

  Future<void> openMap(double lat, double long) async {
    lat = -26.8691307;
    long = -52.4417776;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Não foi possivel abrir o mapa';
    }
  }

  Future<void> openPhone(String phone) async {
    String phoneLaunch = 'tel:' + phone;
    if (await canLaunch(phoneLaunch)) {
      await launch(phoneLaunch);
    } else {
      throw 'Não foi possivel abrir o Telefone';
    }
  }
}
