import 'package:flutter/material.dart';
import 'package:crud_v2/contato_formulario.dart';
import 'package:crud_v2/contato_lista.dart';

class MyApp extends StatelessWidget {
  // this widget is the root of your application
  static const HOME = '/';
  static const CONTATO_FORM = 'contato-form';
  static const CONTATO_LIST = 'contato-list';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contato',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        //HOME: (context) => MyContatoList(),
        CONTATO_FORM: (context) => ContatoFormulario(),
        //CONTATO_LIST: (context) => MyContatoList(),
      },
    );
  }
}
