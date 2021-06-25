import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:futbuilder/models/reqres_model.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MiPagina(),
    );
  }
}

Future<ReqResRespuesta> getUsuarios() async {
  final resp = await http.get(Uri.parse('https://reqres.in/api/users'));
  return reqResRespuestaFromJson(resp.body);
}

class MiPagina extends StatelessWidget {
  //const MiPagina({
  //Key? key,
  //}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _ListaUsuarios(snapshot.data.data);
          }
        },
      ),
    );
  }
}

class _ListaUsuarios extends StatelessWidget {
  final List<Usuario> usuarios;
  //const _ListaUsuarios({
  //Key? key,
  //}) : super(key: key);

  _ListaUsuarios(this.usuarios);

  @override
  Widget build(BuildContext context) {
    //print(this.usuarios);
    return ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (BuildContext context, int i) {
          final usuario = usuarios[i];
          return FadeInLeft(
            delay: Duration(milliseconds: 100 * i),
            child: ListTile(
              title: Text('${usuario.firstName} ${usuario.lastName}'),
              subtitle: Text(usuario.email),
              trailing: Image.network(usuario.avatar),
            ),
          );
        });
  }
}
