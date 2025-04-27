import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/listcontent.dart';

var logger = Logger();

class MyAboutPage extends StatelessWidget{
  const MyAboutPage({super.key});
  /*void _goBackPage(BuildContext context){
    Navigator.pop(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Lab-5-Alfaro-About')
      ),
      persistentFooterButtons: <Widget>[
        TextButton(onPressed: () {Navigator.pop(context, MaterialPageRoute(builder: (context)=> const MyListPage()));}, child: Icon(Icons.keyboard_arrow_left_rounded, size: 40))
      ],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Es que me pase con la Kem Xtreme anoche y no dormi')
          ],
        ),
      )
    );
  }
}
