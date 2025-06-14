import 'dart:math';
import 'package:application_laboratorio/pages/newpage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PhotoAlbumPage extends StatelessWidget{
  const PhotoAlbumPage({super.key, required this.listPhotos});

  final List<Image> listPhotos;

  void changeNameHome(String title) {
    title = 'New Name of page';
  }

  void _goBackPage(BuildContext context){
    Navigator.pop(context);
  }

  Widget photos(){
    if (listPhotos.isEmpty) {
    return Text('No such images in album photos');
  } else {
    return ListView.builder(
      itemCount: listPhotos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: listPhotos[index], // Asegúrate que sea un Widget (ej: Image.file)
        );
      },
    );
  }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Lab 9 - album de fotos'),
      ),
      body: photos(),
      persistentFooterButtons: [
        IconButton(onPressed: () => _goBackPage, icon: Icon(Icons.abc))
      ],
    );
  }
}
