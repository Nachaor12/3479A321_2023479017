import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/listcontent.dart';
//import 'package:application_laboratorio/pages/about.dart';

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
    logger.d("Logger esta funcionando");
    return MaterialApp(
      title: 'Lab-3-Alfaro Home Page',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 100)),
        textTheme: GoogleFonts.blackOpsOneTextTheme()
      ),
      home: const MyHomePage(title: 'Lab-5-Alfaro Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //nt counterPage = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      logger.d("Contador aumenta");
    });
  }
  void _decreaseCounter(){
    setState((){
      _counter--;
      logger.d("Contador disminuye");
    });
  }
  void _resetCounter(){
    setState((){
      _counter = 0;
      logger.d("Contador se reinicia");
    });
  }
  void _nextPage(){
    setState(() {
      logger.d('Se cambio de pantalla');
      /*counterPage++;
      if(counterPage % 2 == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyAboutPage()));
      }
      logger.d('$counterPage');*/
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
    });
  }

  @override
  Widget build(BuildContext context) {

    logger.d("Logger esta funcionando");
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: NewCardWidget(counter: _counter, newMethod: newMethod, context: context),
      persistentFooterButtons: <Widget> [
        TextButton(onPressed: _nextPage, child: Icon(Icons.keyboard_arrow_right_rounded, size: 40))
      ]
    );
  }

  List<Widget> get newMethod {
    return <Widget>[
      TextButton(onPressed: _incrementCounter, child: Icon(Icons.add)),
      TextButton(onPressed: _decreaseCounter, child: Icon(Icons.remove)),
      TextButton(onPressed: _resetCounter, child: Icon(Icons.restart_alt_rounded)),
      TextButton(onPressed: _nextPage, child: Icon(Icons.keyboard_arrow_right_rounded, size: 30))
    ];
  }
}

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({
    super.key,
    required int counter,
    required this.newMethod,
    required this.context,
  }) : _counter = counter;

  final int _counter;
  final List<Widget> newMethod;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    logger.d('Esta es otra Card');
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Color.fromARGB(255, 151, 196, 247),
        child: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 100),
              const Text('      "Flutter es un framework,\nno un lenguaje de programación"', textScaler: TextScaler.linear(1.5)),
              SizedBox(height: 100),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Tu has pusheado este boton estas veces :', textScaler: TextScaler.linear(1.2)),
                  SizedBox(width: 12),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium, 
                  ),
                ],
              ),
              svg,
              SizedBox(height: 50),
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