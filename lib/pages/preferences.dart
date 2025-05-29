import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:application_laboratorio/pages/newpage.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger();


class MyPreferencesPage extends StatefulWidget {
  const MyPreferencesPage({super.key});
  
  @override
  State<MyPreferencesPage> createState() => _MyPreferencesPageState();
}

class _MyPreferencesPageState extends State<MyPreferencesPage> {

  bool _isResetEnabled = false;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isResetEnabled', _isResetEnabled);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadPreferences();
  });
  }

  @override
  void dispose() {
    _savePreferences();
    super.dispose();
  }

  void changeRestart(BuildContext context){
    context.read<AppData>().restartDisponible = !context.read<AppData>().restartDisponible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preferencias")),
      body: Center(
        child: SwitchListTile(
          title: Text("Habilitar reset"),
          value: _isResetEnabled,
          onChanged:(bool value) {
            setState(() {
              _isResetEnabled = value;
            });
            changeRestart(context);
          },
        ),
      ),
    );
  }
}
