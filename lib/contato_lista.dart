import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:crud_v2/database_helper.dart';
import 'package:crud_v2/my_app.dart';
import 'package:crud_v2/contato_formulario.dart';
import 'package:crud_v2/contato_lista.dart';

class ContatoList extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  final _back = ContatoListBack();
  var listaContato;

  Future<List<Contato>> _buscar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas _buscar');
    todasLinhas.forEach((row) => print(row));

    List<Contato> Lista = List.generate(
      todasLinhas.length, (i){
        var linha = todasLinhas[i];
        return Contato(
          id: linha['_id'],
          nome: linha['nome'],
          idade: linha['idade'];
        );
      }
    );
    listaContato = lista;
    return lista;
  }


  Widget iconEditButton(Function onPressed){
    return IconButton(icon: Icon(Icons.edit), color: Colors.orange, onPressed: onPressed());
  }

  Widget iconRemoveButton(BuildContext context, Function remove){
    return IconButton(
      icon: Icon(Icons.delete),
      color: Colors.red,
      onPressed: (){
        showDialog(
          context: context, 
        builder: (context) => AlertDialog(
          title: Text('Excluir'),
          content: Text('Confirmar a Exclusão?'),
          actions: [
           ElevatedButton(child: Text('Não'),
           onPressed: () {
            Navigator.of(context).pop();
           },
           ),
            ElevatedButton(
           child: Text('Sim'),
            onPressed: remove(),
           ), 
          ],
        ));
      });
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Lista de Contatos'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _back.goToForm(context);
          }
        )
      ],
    ),
    body: Observer(builder: (context) {
      return FutureBuilder(future: _buscar(),
      builder: (context, futuro) {
        print(futuro.hasData);
        print(futuro.hasError);
        print(futuro.error);
        print(futuro.hashCode);
        if(!futuro.hasData) {
          return CircularProgressIndicator();
        }else{
          List<Contato>? listaContato = futuro.data;
          return ListView.builder(
            itemCount: listaContato?.length,
            itemBuilder: (context, i){
              var Contato = listaContato![i];
              return ListTile(
                title: Text(Contato.nome!),
                onTap: (){
                  _back.goToDetails(context, Contato);
                },
                subtitle: Text(Contato.idade.toString()),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      iconEditButton((){
                        WidgetsBinding.instance.addPostFrameCallback((_){

                        });
                      }),
                      iconRemoveButton(context,()){
                        _back.remove(Contato.id);
                        WidgetsBinding.instance.addPostFrameCallback((_){ 

                        });
                      }
                    ],
                  ),
                ),
              )
            }
          )
        }
      },
      )
    }),
  )
}
