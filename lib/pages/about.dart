import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/listcontent.dart';
import 'package:application_laboratorio/pages/newpage.dart';
import 'package:application_laboratorio/pages/preferences.dart';
import 'package:provider/provider.dart';

var logger = Logger();

class MyAboutPage extends StatelessWidget{
  const MyAboutPage({super.key});
  /*void _goBackPage(BuildContext context){
    Navigator.pop(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
  }*/

  void goToPreferences(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyPreferencesPage()));
  }

  void changeName(BuildContext context, String text){
    context.read<AppData>().userName = text;
  }

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
            Text('Es que me pase con la Kem Xtreme anoche y no dormi'),
            Text("Presionar para ir a preferences"),
            IconButton(onPressed: () => goToPreferences(context), icon: Icon(Icons.room_preferences, size: 30,)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa tu nombre', 
                border: OutlineInputBorder()
              ),
              onChanged: (value) {
                changeName(context, value);
              },
            )
          ],
        ),
      )
    );
  }
}
