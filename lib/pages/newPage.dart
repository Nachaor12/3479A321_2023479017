import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/listcontent.dart';
import 'package:application_laboratorio/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application_laboratorio/pages/visualactivity.dart';
import 'package:application_laboratorio/pages/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:application_laboratorio/pages/picturescreen.dart';
import 'package:application_laboratorio/pages/photoalbum.dart';


class AppData extends ChangeNotifier {
    int _counter = 0;
    String _userName = "User Name";
    bool restartDisponible = false;

    int get counter => _counter;
    String get userName => _userName;

  void incrementCounter() {
    _counter++;
    notifyListeners();
    //logger.d("Contador ++");
  }
  void decreaseCounter(){
    _counter--;
    notifyListeners();
    //logger.d("Contador disminuye");
  }
  void resetCounter(){
    if(restartDisponible){
      _counter = 0;
    }
    notifyListeners();
    //logger.d("Contador se reinicia");
  }

  set userName(String name) {
    _userName = name;
    notifyListeners();
  }
}

const String iconname = "assets/icons/Icon1.svg";
final Widget svg = SvgPicture.asset(
  iconname,
  semanticsLabel: 'Dart Logo',
  width: 20,
  height: 20,
);

var logger = Logger();




class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Lab-6-Alfaro Home Page',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 100)),
          textTheme: GoogleFonts.blackOpsOneTextTheme()
        ),
        home: const Parent(),
        
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.changeName});

  final String title;
  final VoidCallback changeName;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //State<MyHomePage> createState(){ print("createState"); return _MyHomePageState();}
}

class _MyHomePageState extends State<MyHomePage> {

  bool isResetEnabled = false;
  List<CameraDescription> cameras = [];
  late CameraDescription firstCamera;
  String _imagePath = '';
  bool imagePhoto = false;
  List<Image> listPhoto = [];
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPreferences();
      _loadCameras();
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }

  Future<void> _loadCameras() async {
    cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  void _nextCamera() async {
    final imagePath = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TakePictureScreen(camera:
      firstCamera)),
    );
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
        listPhoto.add(Image.file(File(_imagePath)));
        imagePhoto = true;
      });
    }
  }

  void changeNameHomePage(String text){
    setState(() {
      text = "Mi lab 7";
    });
  }

  void _nextPage(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: "Lab 7", changeName: () => changeNameHomePage("Lab7"),)));
    });
  }
  void _nextPage1(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
    });
  }
  void _nextPage2(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyAboutPage()));
    });
  }
  void _nextPage3(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyVisualPage()));
    });
  }
  void _nextPage4(){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyPreferencesPage()
    )
    ).then((_) {
    _loadPreferences();
    });
  }

  void _goPhotoAlbum(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoAlbumPage(listPhotos: listPhoto,)));
    });
  }
  

  /*
  @override
  void initState() {
    print("initState: $mounted");
    super.initState();
  }
  @override
  void didChangeDependencies() {
    print("didChangeDependencies: $mounted");
    super.didChangeDependencies();
  }
  @override
  void setState(VoidCallback fn) {
    print("setState: $mounted");
    super.setState(fn);
  }*/


  String urlImage = 'https://picsum.photos/250?image=31';

  void _getNewImage() async{
    int counter = context.read<AppData>().counter;

    if(counter < 0){
      counter = -counter;
    }

    try {
    final response = await http.head(Uri.parse(urlImage));
      if (response.statusCode == 200) {
        setState(() {
        final _imageUrl = urlImage;
        });
      } 
      else {
        setState(() {
        final _imageUrl = ''; // Clear the image URL
        });
      }
    } 
    catch (e) {
      setState(() {
        final _imageUrl = ''; // Clear the image URL
      });
    }

    setState(() {
      imagePhoto = false;
      urlImage = 'https://picsum.photos/250?image=${0 + counter}';
    });
  }


  @override
  Widget build(BuildContext context) {

    //print("build called");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        
      ),

      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: TextButton(onPressed: _nextPage, child: Icon(Icons.home, color: Colors.cyanAccent,))),
                Tab(child: TextButton(onPressed: _nextPage1, child: Icon(Icons.inbox, color: Colors.cyanAccent))),
                Tab(child: TextButton(onPressed: _nextPage2, child: Icon(Icons.info, color: Colors.cyanAccent))),
                Tab(child: TextButton(onPressed: _nextPage3, child: Icon(Icons.add_chart, color: Colors.cyanAccent))),
                Tab(child: TextButton(onPressed: _nextPage4, child: Icon(Icons.room_preferences, color: Colors.cyanAccent,),))
              ],
            ),
            title: const Text('Pages', textScaler: TextScaler.linear(1),),
            backgroundColor: const Color.fromARGB(255, 188, 57, 101),
          ),
          body: NewCardWidget(urlImage: urlImage,counter: context.read<AppData>().counter, newMethod: newMethod, context: context, imagePath: _imagePath,imagePhoto: imagePhoto,),
        )
      ),
      persistentFooterButtons: <Widget> [
        TextButton(onPressed: _nextPage, child: Icon(Icons.keyboard_arrow_right_rounded, size: 40)),
        TextButton(onPressed: _nextCamera, child: Icon(Icons.camera_alt, size: 40,)),
        TextButton(onPressed: _goPhotoAlbum, child: Icon(Icons.album)),
      ]
      
    );
  }
  /*
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget: $mounted");
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose: $mounted");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble: $mounted");
  }
  */

  List<Widget> get newMethod {
    return <Widget>[
      TextButton(onPressed: _getNewImage, child: Icon(Icons.image)),
      TextButton(onPressed: context.read<AppData>().incrementCounter, child: Icon(Icons.add)),
      TextButton(onPressed: context.read<AppData>().decreaseCounter, child: Icon(Icons.remove)),
      TextButton(onPressed: context.read<AppData>().resetCounter, child: Icon(Icons.restart_alt_rounded)),
      TextButton(onPressed: _nextPage, child: Icon(Icons.keyboard_arrow_right_rounded, size: 30)),
      //TextButton(onPressed: widget.changeName, child: Icon(Icons.ac_unit_sharp, size: 30))
    ];
  }
}

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({
    super.key,
    required this.urlImage,
    required int counter,
    required this.newMethod,
    required this.context,
    required this.imagePath,
    required this.imagePhoto,
  });
  
  final String urlImage;
  final List<Widget> newMethod;
  final BuildContext context;
  final String imagePath;
  final bool imagePhoto;

  Image imageScreen(){
    if (imagePath.isNotEmpty && imagePhoto) {
      return Image.file(
        File(imagePath),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Text('Error cargando imagen local');
        },
      );
    } else {
      return Image.network(
        urlImage.isNotEmpty ? urlImage : '',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
            'Failed to load image',
            style: TextStyle(color: Colors.red),
            ),
          );
        },
      ); 
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Color.fromARGB(255, 151, 196, 247),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5),
              imageScreen(),
              SizedBox(height: 10),
              const Text('"Flutter es un framework,\n\tno un lenguaje de \n\tprogramación"', textScaler: TextScaler.linear(1.5)),
              SizedBox(height: 15),
              Text('User name: ${context.watch<AppData>().userName}'),
              SizedBox(height: 15,),
              const Text('Tu has pusheado este', textScaler: TextScaler.linear(1.2)),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('boton estas veces :', textScaler: TextScaler.linear(1.2)),
                  SizedBox(width: 12),
                  Text(
                    '${context.watch<AppData>().counter}',
                    style: Theme.of(context).textTheme.headlineMedium, 
                  ),
                ],
              ),
              SizedBox(height: 10),
              svg,
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...newMethod
                ],
              )
            ],
          )
        )
      ),
    );
  }
}

class Parent extends StatefulWidget {
  const Parent({super.key});
  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  String _title = 'Lab-9-Alfaro Home Page';
  
  void pressName(){
    setState(() {
      _title = "Ahora es el Lab 9";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: _title, changeName: pressName,);
  }
}

