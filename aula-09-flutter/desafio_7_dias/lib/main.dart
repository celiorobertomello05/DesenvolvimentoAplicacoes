// =============================================================
// DESAFIO DOS 7 DIAS — desafios por dia + desafios da semana
//
// O arquivo tem 4 partes:
//   PARTE 1 -> cores do app
//   PARTE 2 -> classes de dados e regras (Desafio, ListaDeDesafios, Semana)
//   PARTE 3 -> a tela (só mostra e chama os métodos)
//   PARTE 4 -> janelinha (dialog) para criar/editar um desafio
//
// Como funciona:
//   - Cada um dos 7 dias tem a SUA lista de desafios (o que existe
//     no Dia 1 não aparece no Dia 2).
//   - Existe também a aba "Semana": desafios gerais, valem para
//     a semana inteira.
//
// Pacote extra: add_2_calendar (adicionar ao calendário do celular)
//   flutter pub add add_2_calendar
// =============================================================

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const DesafioApp());
}

// -------------------------------------------------------------
// PARTE 1 — CORES
// -------------------------------------------------------------
class AppColors {
  static const fundoTopo = Color(0xFF1C1B1E);
  static const fundoBase = Color(0xFF3A383D);
  static const lilas = Color(0xFF8B7CF6);
  static const pretoBotao = Color(0xFF111111);
  static const cardFundo = Color(0xFF2A2830);
}

// -------------------------------------------------------------
// PARTE 2 — CLASSES (dados e regras ficam aqui, longe da tela)
// -------------------------------------------------------------

/// Um único desafio: tem título, sabe se foi concluído e sabe se alternar.
class Desafio {
  String titulo;
  bool concluido;

  Desafio(this.titulo, {this.concluido = false});

  void alternar() {
    concluido = !concluido;
  }
}

/// Uma lista de desafios (usada para UM dia ou para a SEMANA).
/// O "_" em _desafios deixa a lista privada: só esta classe mexe nela.
class ListaDeDesafios {
  final List<Desafio> _desafios = [];

  /// Versão "somente leitura": a tela pode olhar, mas não pode alterar.
  List<Desafio> get desafios => List.unmodifiable(_desafios);

  // ---- Getters: valores calculados na hora ----
  int get total => _desafios.length;

  int get totalConcluidos => _desafios.where((d) => d.concluido).length;

  double get progresso => total == 0 ? 0 : totalConcluidos / total;

  bool get completo => total > 0 && totalConcluidos == total;

  // ---- Métodos: as ações permitidas ----
  void adicionar(String titulo) {
    if (titulo.trim().isEmpty) return; // regra: não aceita texto vazio
    _desafios.add(Desafio(titulo.trim()));
  }

  void editar(int indice, String novoTitulo) {
    if (novoTitulo.trim().isEmpty) return;
    _desafios[indice].titulo = novoTitulo.trim();
  }

  void alternar(int indice) {
    _desafios[indice].alternar();
  }

  void excluir(int indice) {
    _desafios.removeAt(indice);
  }

  void reiniciar() {
    for (final desafio in _desafios) {
      desafio.concluido = false;
    }
  }
}

/// A semana inteira: 7 listas (uma por dia) + 1 lista de desafios da semana.
class Semana {
  static const int totalDias = 7;

  /// dias[0] = Dia 1, dias[1] = Dia 2... cada um com os seus desafios
  final List<ListaDeDesafios> dias = List.generate(
    totalDias,
    (_) => ListaDeDesafios(),
  );

  /// Desafios gerais, que valem para a semana toda
  final ListaDeDesafios semanais = ListaDeDesafios();

  List<ListaDeDesafios> get _todas => [...dias, semanais];

  /// aba 0..6 = dias | aba 7 = semana
  ListaDeDesafios listaDaAba(int aba) {
    return aba < totalDias ? dias[aba] : semanais;
  }

  // Progresso geral = soma de tudo (dias + semana)
  int get total => _todas.fold(0, (soma, l) => soma + l.total);

  int get totalConcluidos =>
      _todas.fold(0, (soma, l) => soma + l.totalConcluidos);

  double get progresso => total == 0 ? 0 : totalConcluidos / total;

  bool get completo => total > 0 && totalConcluidos == total;

  void reiniciar() {
    for (final lista in _todas) {
      lista.reiniciar();
    }
  }
}

/// Ações do menu "três pontinhos" de cada desafio.
enum AcaoDesafio { agendar, editar, excluir }

/// Transforma uma data em texto: 30/10/2026
String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes/${data.year}';
}

/// Versão curta, sem o ano: 30/10
String formatarDataCurta(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes';
}

// -------------------------------------------------------------
// PARTE 3 — A TELA
// -------------------------------------------------------------
class DesafioApp extends StatelessWidget {
  const DesafioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desafio dos 7 Dias',
      // Calendário e botões em português
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.lilas,
          onPrimary: Colors.white,
        ),
        popupMenuTheme: const PopupMenuThemeData(color: AppColors.cardFundo),
      ),
      home: const TelaDesafio(),
    );
  }
}

class TelaDesafio extends StatefulWidget {
  const TelaDesafio({super.key});

  @override
  State<TelaDesafio> createState() => _TelaDesafioState();
}

class _TelaDesafioState extends State<TelaDesafio> {
  // O objeto que guarda os dados e as regras
  final Semana semana = Semana();

  // Aba escolhida: 0 a 6 = Dia 1 a Dia 7 | 7 = Semana
  int abaSelecionada = 0;

  // Data escolhida no calendário = dia 1 do desafio
  DateTime dataInicio = DateUtils.dateOnly(DateTime.now());

  /// A lista da aba que está aberta agora.
  ListaDeDesafios get listaAtual => semana.listaDaAba(abaSelecionada);

  bool get abaSemana => abaSelecionada == Semana.totalDias;

  /// Data de cada dia: dia 1 = dataInicio, dia 2 = dataInicio + 1...
  DateTime dataDoDia(int dia) {
    return DateTime(dataInicio.year, dataInicio.month, dataInicio.day + dia);
  }

  /// O calendário nativo só existe no Android e no iOS.
  bool get suportaCalendarioNativo {
    return !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
  }

  // ---------------- Ações ----------------

  Future<void> abrirDialogoDesafio({int? indiceParaEditar}) async {
    // Guarda a lista de agora (caso o usuário troque de aba com a janela aberta)
    final ListaDeDesafios alvo = listaAtual;

    final String? texto = await showDialog<String>(
      context: context,
      builder: (_) => DialogoDesafio(
        textoInicial: indiceParaEditar != null
            ? alvo.desafios[indiceParaEditar].titulo
            : '',
      ),
    );

    if (texto == null || !mounted) return; // usuário cancelou

    setState(() {
      if (indiceParaEditar != null) {
        alvo.editar(indiceParaEditar, texto);
      } else {
        alvo.adicionar(texto);
      }
    });
  }

  void executarAcao(AcaoDesafio acao, int indice) {
    switch (acao) {
      case AcaoDesafio.agendar:
        adicionarAoCalendarioDoCelular(indice);
      case AcaoDesafio.editar:
        abrirDialogoDesafio(indiceParaEditar: indice);
      case AcaoDesafio.excluir:
        setState(() => listaAtual.excluir(indice));
    }
  }

  Future<void> adicionarAoCalendarioDoCelular(int indice) async {
    if (!suportaCalendarioNativo) {
      mostrarMensagem(
        'O calendário do celular só funciona no Android e no iOS.',
      );
      return;
    }

    final Desafio desafio = listaAtual.desafios[indice];
    final Event evento;

    if (abaSemana) {
      // Desafio da semana: evento de dia inteiro, do dia 1 ao dia 7
      evento = Event(
        title: desafio.titulo,
        description: 'Desafio da semana',
        startDate: dataDoDia(0),
        endDate: dataDoDia(Semana.totalDias - 1),
        allDay: true,
      );
    } else {
      // Desafio de um dia: evento às 09:00 naquele dia
      final dia = dataDoDia(abaSelecionada);
      final inicio = DateTime(dia.year, dia.month, dia.day, 9);
      evento = Event(
        title: desafio.titulo,
        description: 'Dia ${abaSelecionada + 1} do Desafio dos 7 Dias',
        startDate: inicio,
        endDate: inicio.add(const Duration(hours: 1)),
      );
    }

    try {
      // Abre o app de calendário do celular para o usuário confirmar
      await Add2Calendar.addEvent2Cal(evento);
    } catch (erro) {
      debugPrint('Erro ao abrir o calendário: $erro');
      if (!mounted) return;
      mostrarMensagem('Não foi possível abrir o calendário.');
    }
  }

  void mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  // ---------------- Pedaços da tela ----------------

  Widget construirCabecalho() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white24,
          child: Text(
            'CM',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '${semana.totalConcluidos} de ${semana.total}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            IconButton(
              tooltip: 'Reiniciar desafios',
              icon: const Icon(Icons.refresh, color: Colors.white54),
              onPressed: () => setState(() => semana.reiniciar()),
            ),
          ],
        ),
      ],
    );
  }

  Widget construirTitulo() {
    return const Padding(
      padding: EdgeInsets.only(top: 18, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 6),
            child: Text(
              '01',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
          Text(
            'desafios',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }

  Widget construirProgresso() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardFundo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Seu progresso',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '${(semana.progresso * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.lilas,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: semana.progresso,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              color: AppColors.lilas,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${semana.totalConcluidos} de ${semana.total} desafios concluídos',
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// O calendário: o usuário escolhe quando o desafio começa.
  Widget construirCalendario() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 4),
      decoration: BoxDecoration(
        color: AppColors.cardFundo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Início do desafio: ${formatarData(dataInicio)}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          CalendarDatePicker(
            initialDate: dataInicio,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            onDateChanged: (novaData) {
              setState(() => dataInicio = novaData);
            },
          ),
        ],
      ),
    );
  }

  /// Uma "abinha" (Dia 1, Dia 2 ... Dia 7, Semana).
  Widget construirAba(int aba) {
    final bool ehSemana = aba == Semana.totalDias;
    final bool selecionada = aba == abaSelecionada;
    final ListaDeDesafios lista = semana.listaDaAba(aba);

    final String titulo = ehSemana ? 'Semana' : 'Dia ${aba + 1}';
    final String subtitulo = ehSemana
        ? 'geral'
        : formatarDataCurta(dataDoDia(aba));

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => abaSelecionada = aba),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selecionada ? AppColors.lilas : AppColors.cardFundo,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitulo,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
              if (lista.total > 0)
                Text(
                  '${lista.totalConcluidos}/${lista.total}',
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// A fileira de abas: Dia 1 ... Dia 7 e Semana (rola para o lado).
  Widget construirAbas() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int aba = 0; aba <= Semana.totalDias; aba++) construirAba(aba),
        ],
      ),
    );
  }

  Widget construirTituloDaAba() {
    final String texto = abaSemana
        ? 'Desafios da semana (valem para os 7 dias)'
        : 'Desafios do Dia ${abaSelecionada + 1} · '
              '${formatarData(dataDoDia(abaSelecionada))}';

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }

  Widget construirCardDesafio(int indice) {
    final Desafio desafio = listaAtual.desafios[indice];
    final bool feito = desafio.concluido;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 6, 4, 6),
      decoration: BoxDecoration(
        color: AppColors.cardFundo,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
        border: feito
            ? Border.all(color: AppColors.lilas.withValues(alpha: 0.4))
            : null,
      ),
      child: Row(
        children: [
          // Bolinha de marcar / desmarcar
          GestureDetector(
            onTap: () => setState(() => listaAtual.alternar(indice)),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: feito ? AppColors.lilas : Colors.transparent,
                border: Border.all(
                  color: feito ? AppColors.lilas : Colors.white38,
                  width: 1.5,
                ),
              ),
              child: feito
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Título + etiqueta (Dia X ou Semana)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    desafio.titulo,
                    style: TextStyle(
                      color: feito ? Colors.white54 : Colors.white,
                      fontSize: 13,
                      decoration: feito
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: feito
                          ? AppColors.lilas.withValues(alpha: 0.2)
                          : AppColors.pretoBotao,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      abaSemana
                          ? 'Semana · ${formatarDataCurta(dataDoDia(0))} a '
                                '${formatarDataCurta(dataDoDia(Semana.totalDias - 1))}'
                          : 'Dia ${abaSelecionada + 1} · '
                                '${formatarData(dataDoDia(abaSelecionada))}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Menu com as ações (cabe em qualquer largura de tela)
          PopupMenuButton<AcaoDesafio>(
            icon: const Icon(Icons.more_vert, color: Colors.white54),
            onSelected: (acao) => executarAcao(acao, indice),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: AcaoDesafio.agendar,
                child: Text('Adicionar ao calendário do celular'),
              ),
              PopupMenuItem(value: AcaoDesafio.editar, child: Text('Editar')),
              PopupMenuItem(value: AcaoDesafio.excluir, child: Text('Excluir')),
            ],
          ),
        ],
      ),
    );
  }

  Widget construirBotaoAdicionar() {
    return Center(
      child: GestureDetector(
        onTap: () => abrirDialogoDesafio(),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: AppColors.pretoBotao,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ListaDeDesafios lista = listaAtual;

    return Scaffold(
      backgroundColor: AppColors.fundoBase,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.fundoTopo, AppColors.fundoBase],
          ),
        ),
        child: SafeArea(
          child: Center(
            // Responsivo: ocupa a tela toda no celular e,
            // em telas largas, para de crescer em 480 px.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    construirCabecalho(),
                    construirTitulo(),
                    construirProgresso(),
                    const SizedBox(height: 14),
                    // Calendário + abas + lista rolam juntos
                    Expanded(
                      child: ListView(
                        children: [
                          construirCalendario(),
                          const SizedBox(height: 14),
                          construirAbas(),
                          const SizedBox(height: 12),
                          construirTituloDaAba(),
                          const SizedBox(height: 10),
                          if (lista.total == 0)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                abaSemana
                                    ? 'Toque no + para criar um desafio da semana.'
                                    : 'Toque no + para criar um desafio deste dia.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white60),
                              ),
                            ),
                          for (int i = 0; i < lista.total; i++)
                            construirCardDesafio(i),
                        ],
                      ),
                    ),
                    if (semana.completo)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Parabéns! Você completou os desafios!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    construirBotaoAdicionar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// PARTE 4 — JANELINHA PARA CRIAR / EDITAR
// É um widget separado para o TextEditingController ser
// descartado (dispose) corretamente quando a janela fecha.
// -------------------------------------------------------------
class DialogoDesafio extends StatefulWidget {
  final String textoInicial;

  const DialogoDesafio({super.key, this.textoInicial = ''});

  @override
  State<DialogoDesafio> createState() => _DialogoDesafioState();
}

class _DialogoDesafioState extends State<DialogoDesafio> {
  late final TextEditingController controller = TextEditingController(
    text: widget.textoInicial,
  );

  bool get editando => widget.textoInicial.isNotEmpty;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Fecha a janela devolvendo o texto digitado para a tela
  void confirmar() {
    Navigator.pop(context, controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardFundo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        editando ? 'Editar desafio' : 'Novo desafio',
        style: const TextStyle(color: Colors.white),
      ),
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (_) => confirmar(),
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColors.lilas,
        decoration: InputDecoration(
          hintText: 'Digite o desafio',
          hintStyle: const TextStyle(color: Colors.white38),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lilas),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white60),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lilas,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: confirmar,
          child: Text(editando ? 'Salvar' : 'Adicionar'),
        ),
      ],
    );
  }
}
