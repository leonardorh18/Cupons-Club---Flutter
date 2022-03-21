import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teste/views/home.dart';
import 'dart:core';
import 'package:teste/Utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:teste/DAO/UsuarioDAO.dart';
import 'package:teste/views/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsuarioDAO usuarioDAO = UsuarioDAO();
  Utils utils = Utils();
  bool _passwordVisible = true;

  validarLogin() async {
    bool isValid = EmailValidator.validate(emailController.text.trim());
    if (!isValid) {
      Navigator.of(context).pop();
      utils.showMessageUp('Digite um email valido!');
    } else {
      var usuario = await usuarioDAO.login(
          emailController.text.trim(), passwordController.text.trim());
      if (usuario is bool) {
        Navigator.of(context).pop();
        utils.showMessageUp('Senha ou email errados!');
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nome', usuario.getNome.toString());
        await prefs.setString('email', usuario.getEmail.toString());
        await prefs.setString('senha', usuario.getSenha.toString());
        await prefs.setString('telefone', usuario.getTelefone.toString());
        await prefs.setString('id', usuario.getId.toString());
        await prefs.setBool('logado', true);
        print('NOMEEEEEEEE' + prefs.getString('nome').toString());
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: Home(usuario)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, //i like transaparent :-)
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
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
                                'assets/images/Logo.png',
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
                        controller: emailController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserratAlternates(
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
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
                        obscureText: _passwordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserratAlternates(
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                          ),
                          labelText: 'Senha',
                          suffixIcon: IconButton(
                            color: Colors.red,
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
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
                      onPressed: () async {
                        //ir para a tela de Cadastro

                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Cadastro()));
                      },
                      child: Text(
                        'Criar minha conta',
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
                            onPressed: () async {
                              utils.loading(context);
                              await validarLogin();
                            },
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
            )));
  }
}
