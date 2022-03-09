import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teste/views/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'), // sdd
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
                      child: Image.asset(
                        'assets/images/login.png',
                        width: 200,
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Faça login para entrar no aplicativo',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserratAlternates(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.black,
                controller: nameController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.montserratAlternates(
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
                  labelStyle: GoogleFonts.montserratAlternates(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  labelText: 'Senha',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black, // Text Color
              ),
              onPressed: () {
                //forgot password screen
              },
              child: Text(
                'Esqueci a senha',
                style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                //forgot password screen
              },
              child: Text(
                'Criar conta',
                style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.bold),
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
                      'Entrar',
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Home()));
                    },
                    // style: ElevatedButton.styleFrom(
                    //   primary: Color(0xffEC6262), // Background color
                    // ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffEC6262),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    )
    
    );
  }
}
