import 'dart:math';

import 'package:flutter/material.dart';
import 'package:application_laboratorio/pages/newpage.dart';
import 'package:provider/provider.dart';
import 'package:application_laboratorio/entity/activity.dart';
import 'package:application_laboratorio/services/database_helper.dart';


class MyVisualPage extends StatefulWidget {
  const MyVisualPage({super.key});
  
  @override
  State<MyVisualPage> createState() => _MyVisualPageState();
}

class _MyVisualPageState extends State<MyVisualPage> {
  int idCounteer = 1;
  String titleAux = "Activities";
  bool isEditing = false;
  bool gotId = false;
  int? indexValue;
  List<String> months = [
    "marzo",
    "abril",
    "mayo",
    "junio",
    "julio",
    "agosto",
    "septiembre",
    "octubre",
    "noviembre",
    "diciembre",
  ];
  final random = Random();

  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Activity> _activities = [];

  void changeRestart(BuildContext context){
    context.read<AppData>().restartDisponible = !context.read<AppData>().restartDisponible;
  }

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  void _loadActivities() async {
    final activities = await _dbHelper.getActivities();

    if (activities.isEmpty) {
      final firstActivity = Activity(id: idCounteer, name: "Laboratorio $idCounteer", date: "28 de marzo del 2025");

      await _dbHelper.insertActivity(firstActivity);

      final updatedActivities = await _dbHelper.getActivities();
      idCounteer++;
      setState(() {
        _activities = updatedActivities;
      });
    }
    else{
      setState(() {
        _activities = activities;
      });
    }
  }

  void newActivity() async{
    if(!isEditing){
      int dateCounter = 0 + random.nextInt(31);
      String dateMonth = months[random.nextInt(months.length)];

      final newactivitie = Activity(id: idCounteer, name: "Laboratorio $idCounteer", date: "$dateCounter de $dateMonth de 2025");
      await _dbHelper.insertActivity(newactivitie);
      final activitie = await _dbHelper.getActivities();
      idCounteer++;
      setState(() {
        _activities = activitie;
      });
    }
  }

  void quitActivity() async{
    if(!isEditing) {
      await _dbHelper.deleteActivity(_activities.length);
      final activities = await _dbHelper.getActivities();
      idCounteer--;
      if(idCounteer <= 0){
        idCounteer = 1;
      }
      setState((){
        _activities = activities;
      });
    }
    
  }

  void deleteDataBase() async{
    if(!isEditing) {
      await _dbHelper.deleteDataBase();
      final activities = await _dbHelper.getActivities();
      idCounteer = 1;
      setState((){
        _activities = activities;
      });
    }
  }

  void selectEditActivity(){
    setState(() {
      isEditing = !isEditing;
      gotId = false;
    });
  }

  Widget selectActivity(){
    if(gotId && indexValue != null){
      return ListTile(
        title: Center(
          heightFactor: 1,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ingresa Name de la actividad', 
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  editActivity(value, 1);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ingresa Date de la actividad', 
                  border: OutlineInputBorder()
                ),
                onChanged: (value) {
                  editActivity(value, 2);
                },
              )
            ],
          )
        ),
      );
    }
    return ListTile(
      title: Center(
        heightFactor: 1,
        child: Column(
          children: [
            TextField(
            decoration: InputDecoration(
              labelText: 'Ingresa ID de la actividad', 
              border: OutlineInputBorder()
            ),
            onChanged: (value) {
              setState(() {
                indexValue = int.tryParse(value);
                gotId = indexValue != null;
              });
            },
          )
          ],
        )
      )
    );
  }

  void editActivity(String value, int option) async{
    if (indexValue == null) return;

    final index = _activities.indexWhere((a) => a.id == indexValue);
    if (index == -1) return;

    switch (option){
      case 1:
        _activities[index].name  = value;
        break;
      case 2:
        _activities[index].date  = value;
        break;
    }
    await _dbHelper.updateDog(_activities[index]);
    setState(() {});
  }


  Widget seeWidget(){
    if(isEditing){
      return selectActivity();
    }
    return ListView.builder(
      itemCount: _activities.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Center(
            heightFactor: 2,
            child: Text(
              _activities[index].toString()
            ),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleAux)),
      body: seeWidget(),
      persistentFooterButtons: <Widget> [
        TextButton(onPressed: newActivity, child: Icon(Icons.add, size: 40)),
        TextButton(onPressed: quitActivity, child: Icon(Icons.remove, size: 40)),
        TextButton(onPressed: deleteDataBase, child: Icon(Icons.delete, size: 40)),
        TextButton(onPressed: selectEditActivity, child: Icon(Icons.edit, size: 40))
      ]
    );
  }
}