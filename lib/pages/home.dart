import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: "metalica", votes: 4),
    Band(id: '2', name: "queen", votes: 43),
    Band(id: '3', name: "heroes ", votes: 42),
    Band(id: '4', name: "bon jovi", votes: 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "bandnames",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 8,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) {
            return _bandTile(bands[index]);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 6,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("delete ",style: TextStyle(color: Colors.white),),
        )
      ),
      onDismissed: (direction) {
        // Eliminar el elemento despedido de la lista
        setState(() {
          bands.remove(band);
        });
        // Ya que el widget Dismissible se eliminará automáticamente
        print("Elemento despedido: ${band.name}");
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        subtitle: Text("hola"),
        trailing: Text(
          "${band.votes}",
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }


  addNewBand() {
    final textController = new TextEditingController();
    // if (Platform.isAndroid) {
    //   print("se detecta que es android");
    //   return showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text("new band"),
    //           content: TextField(
    //             controller: textController,
    //           ),
    //           actions: <Widget>[
    //             MaterialButton(
    //                 child: Text("add"),
    //                 elevation: 5,
    //                 textColor: Colors.blueAccent,
    //                 onPressed: () => Navigator.pop(context))
    //           ],
    //         );
    //       });
    // }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("new band name"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("addxx"),
                  onPressed: () => addBandToList(textController.text)),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("dismiss"),
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      this.bands
          .add(new Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
