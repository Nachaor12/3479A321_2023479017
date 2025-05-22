import 'package:application_laboratorio/pages/about.dart';
import 'package:application_laboratorio/pages/newpage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

final List<String> newTextList= [
'Pero Rodrigo', 
'como va a ser', 
'lenguaje de programacion',
'si en la pagina anterior', 
'decia que era un framework'
];

class MyListPage extends StatelessWidget{
  const MyListPage({super.key});
  /*void _goBackPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage(title: 'Lab-5-Alfaro')));
  }
  void _goNextPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyAboutPage()));
  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Lab-5-Alfaro-List-Content')
      ),
      persistentFooterButtons: <Widget>[
        TextButton(onPressed: () {Navigator.pop(context);},
        child: Icon(Icons.keyboard_arrow_left_rounded, size: 40)),
        TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyAboutPage()));}, 
        child: Icon(Icons.keyboard_arrow_right_rounded, size: 40))
      ],
      body: ListView.builder(
        itemCount: newTextList.length, 
        itemBuilder: (context, index){
          return ListTile(
            title: Center(
              heightFactor: 5,
              child: Text(newTextList[index]),
            )
          );
        })
    );
  }
}
