// ============================================================
// ATIVIDADE — COMPLETE O CÓDIGO 
// App: Dado da Sorte
//
// Preencha cada ____ para o app funcionar. Cada espaço em
// branco corresponde a um dos TIPOS DE FUNÇÃO vistos na aula.
// Os números nos comentários indicam qual tipo é esperado ali.
//
//   1) Função de Nível Superior     6) Função Assíncrona (async/await)
//   2) Método (dentro de classe)    7) Override
//   3) Função Nomeada Normal        8) Função Anônima
//   4) Arrow Function (=>)          9) Callback (referência a função)
//   5) Getter                       *) Bônus: operador comum do Dart
//
// Depois de preencher tudo, rode "flutter run" e jogue o dado!
// ============================================================

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// 1) FUNÇÃO DE NÍVEL SUPERIOR — qual widget principal deve iniciar o app?
void main() {
  runApp(const DadoApp());
}

class DadoApp extends StatelessWidget {
  const DadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dado da Sorte',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const TelaDado(),
    );
  }
}

class TelaDado extends StatefulWidget {
  const TelaDado({super.key});

  // 2) MÉTODO — complete com o nome da classe de estado (começa com _)
  @override
  State<TelaDado> createState() => 
  _TelaDadoState();
}

class _TelaDadoState extends State<TelaDado> {
  int _resultado = 1;
  int _totalDeJogadas = 0;
  bool _rolando = false;
  final Random _sorteador = Random();

  // 3) FUNÇÃO NOMEADA NORMAL — sorteia um número de 1 a 6
  //    dica: método do Random que sorteia um inteiro
  int _sortearNumero() {
    return _sorteador.nextInt(6) + 1;
  }

  // 4) ARROW FUNCTION — transforma o número sorteado em texto
  String _numeroParaTexto(int numero) => numero.toString();

  // 5) GETTER — devolve uma frase engraçada de acordo com o resultado
  //    dica: toda função aqui precisa "devolver" um valor
  String get _mensagemDaSorte {
    if (_resultado == 6) return '=) Sorte grande! Número da vez!';
    if (_resultado == 1) return '=() Foi só o 1... tenta de novo!';
    return 'Nada mal! Você tirou o $_resultado.';
  }

  // 6) FUNÇÃO ASSÍNCRONA — rola o dado com uma pequena espera
  //    dica 1: palavra-chave que marca a função como assíncrona
  //    dica 2: classe/método usado para esperar um tempo
  Future<void> _rolarDado() async {
    setState(() {
      _rolando = true;
    });

    await Future.delayed (const Duration(milliseconds: 700));

    setState(() {
      _resultado = _sortearNumero();
      _totalDeJogadas++; // *) BÔNUS: operador que soma 1 à variável
      _rolando = false;
    });
  }

  void _reiniciarContagem() {
    setState(() {
      _totalDeJogadas = 0;
    });
  }

  // 7) OVERRIDE — avisa o Dart que build() está sendo reescrito
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎲 Dado da Sorte')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _rolando ? '🎲 Rolando...' : _numeroParaTexto(_resultado),
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              _rolando ? '' : _mensagemDaSorte,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // 8) FUNÇÃO ANÔNIMA — função sem nome, escrita na hora
            ElevatedButton(
              onPressed: _rolando
                  ? null
                  : () {
                      _rolarDado();
                    },
              child: const Text('Rolar dado'),
            ),
            const SizedBox(height: 12),

            // 9) CALLBACK — passe a função (sem chamá-la!) para o botão
            TextButton(
              onPressed: _reiniciarContagem,
              child: const Text('Reiniciar contagem'),
            ),
            const SizedBox(height: 12),
            Text('Jogadas: $_totalDeJogadas'),
          ],
        ),
      ),
    );
  }
}
