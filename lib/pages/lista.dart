import 'package:flutter/material.dart';
import '../dbhelper.dart';
import '../models.dart';


class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  bool _loading_ = true;
  late List<Contato> contatos;

  @override
  void initState() {
    super.initState();
    _carregarBD();
  }

  void _carregarBD() {
    DBHelper.getInstance().then(
      (value) => value.getAllContatos()
    .then((value) => {setState(() => contatos = value)})
    .whenComplete(() => _loading_ = false));
  }

  ListTile _itemList_(BuildContext context, int indice){
    Contato c = contatos[indice];

    return ListTile(title: Text(c.nome), subtitle: Text(c.telefone));
  }

  @override
  Widget build(BuildContext context){
    if(_loading_){
      return const Scaffold(body: const Text("Carregando"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Contatos cadastrados")),
      body: ListView.builder(itemBuilder: _itemList_, itemCount: contatos.length,)
      );
  }
}