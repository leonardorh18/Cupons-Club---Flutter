


import 'package:mysql1/mysql1.dart';

class Conn{
  

  var settings = new ConnectionSettings(
      host: 'dcrhg4kh56j13bnu.cbetxkdyhwsb.us-east-1.rds.amazonaws.com', 
      port: 3306,
      user: 'chem8a1ut6wgqxdl',
      password: 'p92s8wmusf2nbj8s',
      db: 'wil6y59f2kuvwmhf'
    );

  connectDB() async {

    try {

      final conn = await MySqlConnection.connect(this.settings);

    return conn;

    } catch (e){

      print("ERRO AO CONECTAR AO DB");
      throw Exception(e.toString());
      
    }


  }

  

}
