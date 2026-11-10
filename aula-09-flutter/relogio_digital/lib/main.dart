import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const RelogioApp());
  
}


class RelogioApp extends StatelessWidget {
  const RelogioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
         ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      supportedLocales: const [
      Locale('pt', 'BR'),
      ],
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RelogioJanela(),
              SizedBox(
                width: 350,
                child: CupertinoCalendar(
                minimumDateTime: DateTime(2025, 1, 1),
                maximumDateTime: DateTime(2029, 1, 31),
                initialDateTime: DateTime.now(),
                currentDateTime: DateTime.now(),
                timeLabel: 'Hora',
                mode: CupertinoCalendarMode.dateTime,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RelogioJanela extends StatefulWidget {
  const RelogioJanela({super.key});

  @override
  State<RelogioJanela> createState() => _RelogioJanelaState();
}

class _RelogioJanelaState extends State<RelogioJanela> {
  String _hora = '';
  Timer? _timer;

  

  @override
  void initState() {
    super.initState();

    _hora = _horaAtual();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          _hora = _horaAtual();
        });
      },
    );
  }

  String _horaAtual() {
    final agora = DateTime.now();

    String doisDigitos(int numero) {
      return numero.toString().padLeft(2, '0');
    }

    return '${doisDigitos(agora.hour)}:'
        '${doisDigitos(agora.minute)}:'
        '${doisDigitos(agora.second)}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _hora,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }


  
}
