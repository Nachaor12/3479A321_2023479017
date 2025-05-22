import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/listcontent.dart';
import 'package:provider/provider.dart';



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
  State<MyHomePage> createState(){
    print("createState");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  void _nextPage(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
    });
  }
  void _nextPage2(){
    setState(() {
      //logger.d('Se cambio de pantalla');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyListPage()));
    });
  }


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
  }

  @override
  Widget build(BuildContext context) {

    print("build called");
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: NewCardWidget(counter: context.read<AppData>().counter, newMethod: newMethod, context: context),
      persistentFooterButtons: <Widget> [
        TextButton(onPressed: _nextPage2, child: Icon(Icons.keyboard_arrow_right_rounded, size: 40))
      ]
    );
  }

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


  List<Widget> get newMethod {
    return <Widget>[
      TextButton(onPressed: context.read<AppData>().incrementCounter, child: Icon(Icons.add)),
      TextButton(onPressed: context.read<AppData>().decreaseCounter, child: Icon(Icons.remove)),
      TextButton(onPressed: context.read<AppData>().resetCounter, child: Icon(Icons.restart_alt_rounded)),
      TextButton(onPressed: _nextPage, child: Icon(Icons.keyboard_arrow_right_rounded, size: 30)),
      TextButton(onPressed: widget.changeName, child: Icon(Icons.ac_unit_sharp, size: 30))
    ];
  }
}

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({
    super.key,
    required int counter,
    required this.newMethod,
    required this.context,
  });
  
  final List<Widget> newMethod;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Color.fromARGB(255, 151, 196, 247),
        child: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50),
              const Text('      "Flutter es un framework,\nno un lenguaje de programación"', textScaler: TextScaler.linear(1.5)),
              SizedBox(height: 50),
              Text('User name: ${context.watch<AppData>().userName}'),
              SizedBox(height: 50,),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Tu has pusheado este boton estas veces :', textScaler: TextScaler.linear(1.2)),
                  SizedBox(width: 12),
                  Text(
                    '${context.watch<AppData>().counter}',
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

class Parent extends StatefulWidget {
  const Parent({super.key});
  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  String _title = 'Lab-5-Alfaro Home Page';
  
  void pressName(){
    setState(() {
      _title = "Ahora es el Lab 6";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: _title, changeName: pressName,);
  }
}