import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:application_laboratorio/pages/newpage.dart';


class TakePictureScreen extends StatefulWidget{
  final CameraDescription camera;
  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>{
  
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _gohomepage() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      persistentFooterButtons: [
        IconButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              if (!context.mounted) return;
              Navigator.of(context).pop(image.path);
            }catch (e){
              print(e);
            }
          },
          icon: Icon(Icons.picture_in_picture)
        ),
        IconButton(onPressed: _gohomepage, icon: Icon(Icons.arrow_back))
      ],

    );
  }
}


class PreviewPictureScreen extends StatelessWidget {
  final String imagePath;
  const PreviewPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa foto')),
      body: Image.file(File(imagePath)),
    );
  }
}