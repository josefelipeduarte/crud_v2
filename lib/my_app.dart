import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 35, 38, 204)),
      ),
      routes: {
        HOME: (context) => MyContatoList(),
        CONTATO_FORM: (context) => ContatoFormulario(),
        CONTATO_LIST: (context) => MyContatoList(),
      },
    );
  }
}
