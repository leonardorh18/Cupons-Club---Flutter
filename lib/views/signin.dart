import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), // sdd
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      child: const Text('Boas vindas!',
                      textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                      ),
                    ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Venha conosco desfrutar as ofertas!',
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 30,
                            color: Colors.black),

                         textAlign: TextAlign.center,
                         //style: TextStyle(
                       
                        )),

// child: Text(
//                       'Entrar',
//                       style: GoogleFonts.montserratAlternates(
//                           fontSize: 20, color: Colors.white),
//                     ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.black,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  labelText: 'E-mail ou telefone',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                cursorColor: Colors.black,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  labelText: 'E-mail ou telefone',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black, // Text Color
              ),
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Esqueci a senha',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black, // Text Color
              ),
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Criar conta',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Container(
                  height: 50,
                  width: 300,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(
                      'Criar Conta',
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffEC6262), // Background color
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
