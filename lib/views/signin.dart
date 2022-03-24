import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teste/views/home.dart';
import 'package:teste/DAO/UsuarioDAO.dart';
import 'package:email_validator/email_validator.dart';
import 'package:teste/Utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:core';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var phoneMask = new MaskTextInputFormatter(
      //Máscara de Formatação
      mask: '+55 (##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);


  UsuarioDAO usuarioDAO = UsuarioDAO();
  Utils utils = Utils();

  validarSignin() async {
    int alright = 1;
    if (nameController.text.length > 0 || passwordController.text.length > 0 || emailController.text.length > 0) {
      EmailValidator.validate(emailController.text.trim()) ? print('O email é válido') : utils.showMessageUp('Digite um e-mail válido!'); 
      phoneMask.getUnmaskedText().length > 8 ? alright++ : utils.showMessageUp('O telefone deve ser preenchido corretamente!');
      nameController.text.length > 3 ? alright++ : utils.showMessageUp('O nome deve ter mais que 3 caracteres!');
      passwordController.text.length > 6 ? alright++ : utils.showMessageUp('A senha deve ter mais que 6 caracteres!');

      //checa se o usuário possui telefone ou email já cadastrado no banco
      if (await usuarioDAO.checkBD(emailController.text.trim(), phoneMask.getUnmaskedText().trim()) == false) { 
        utils.showMessageUp('Telefone ou E-mail já cadastrado, tente outros!'); //ver se algum deles já existem no banco
        alright = 1; // not alright 
      }
      Navigator.of(context).pop();
    }
    else {
      utils.showMessageUp('Preencha todos os campos!');
      Navigator.of(context).pop();
    }
    print(alright);
    if (alright == 4) {
      print(emailController.text);
      print(phoneMask.getUnmaskedText().toString().trim());
      print(nameController.text);
      print(passwordController.text);
      await usuarioDAO.signin(emailController.text, phoneMask.getUnmaskedText().toString().trim(), nameController.text, passwordController.text);
      var usuario = await usuarioDAO.login(emailController.text.trim(), passwordController.text.trim());

      final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nome', usuario.getNome.toString());
        await prefs.setString('email', usuario.getEmail.toString());
        await prefs.setString('senha', usuario.getSenha.toString());
        await prefs.setString('telefone', usuario.getTelefone.toString());
        await prefs.setString('id', usuario.getId.toString());
        await prefs.setBool('logado', true);
        

      Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: Home(usuario)));
      }
    }
  

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, //cor da barra de notificação
          systemNavigationBarColor: Colors.white, //cor da barra de baixo
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView( 
                child: Container (
                height: MediaQuery.of(context).size.height,
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
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Boas Vindas!',
                                    style: GoogleFonts.montserratAlternates(
                                        fontSize: 30, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Venha conosco desfrutar as ofertas!',
                                    style: GoogleFonts.montserratAlternates(
                                        fontSize: 23, color: Colors.black),
                                    textAlign: TextAlign.center,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z]')),
                          ],
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Mont Serrat',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            labelText: 'Nome',
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
                              fontFamily: 'Mont Serrat',
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
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Mont Serrat',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            labelText: 'E-mail',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          inputFormatters: [phoneMask],
                          cursorColor: Colors.black,
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Mont Serrat',
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            labelText: 'Telefone',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
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
                                  onPressed: () async {
                                    print(nameController.text);
                                    print(passwordController.text);
                                    print(phoneController.text);
                                    print(emailController.text);
                                    
                                    utils.loading(context);
                                    await validarSignin();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xffEC6262)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                    ),
                                  )),
                            )),
                      ),
                    ])),
          ),
        )));
  }
}
