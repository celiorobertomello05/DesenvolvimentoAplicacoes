import 'dart:io';

import 'package:meu_app/carro.dart';
import 'package:meu_app/moto.dart';
import 'package:meu_app/veiculo.dart';

// ── Utilitários de terminal ───────────────────────────────────────────────────

void limparTela() {
  print('\x1B[2J\x1B[0f');
}

void pausar() {
  stdout.write('\nPressione Enter para continuar...');
  stdin.readLineSync();
}

// ── Utilitários de entrada ────────────────────────────────────────────────────

/// Lê texto e rejeita entrada vazia, ficando em loop até o usuário digitar algo.
String lerTexto(String prompt) {
  while (true) {
    stdout.write('$prompt ');
    final entrada = stdin.readLineSync()?.trim() ?? '';
    if (entrada.isNotEmpty) return entrada;
    print('  Entrada não pode ser vazia. Tente novamente.');
  }
}

/// Lê um double com validação de formato.
double lerDouble(String prompt) {
  while (true) {
    stdout.write('$prompt ');
    final entrada = stdin.readLineSync()?.trim() ?? '';
    final valor = double.tryParse(entrada);
    if (valor != null) return valor;
    print('  Valor inválido. Digite um número (ex: 120.50).');
  }
}

/// Lê um int com validação de formato.
int lerInt(String prompt) {
  while (true) {
    stdout.write('$prompt ');
    final entrada = stdin.readLineSync()?.trim() ?? '';
    final valor = int.tryParse(entrada);
    if (valor != null) return valor;
    print('  Valor inválido. Digite um número inteiro.');
  }
}

// ── Menu e seleção ────────────────────────────────────────────────────────────

int exibirMenu() {
  print('');
  print('╔══════════════════════════════════╗');
  print('║   AGÊNCIA DE VEÍCULOS DO CELIO   ║');
  print('╠══════════════════════════════════╣');
  print('║  1 - Cadastrar Carro             ║');
  print('║  2 - Cadastrar Moto              ║');
  print('║  3 - Listar Veículos             ║');
  print('║  4 - Editar Veículo              ║');
  print('║  5 - Excluir Veículo             ║');
  print('║  6 - Alugar Veículo              ║');
  print('║  0 - Sair                        ║');
  print('╚══════════════════════════════════╝');
  return lerInt('Escolha uma opção:');
}

/// Exibe a lista numerada e retorna o índice (base 0) escolhido pelo usuário.
int selecionarVeiculo(List<Veiculo> veiculos, String titulo) {
  print('\n--- $titulo ---');
  for (var i = 0; i < veiculos.length; i++) {
    print('\n[${i + 1}]');
    print(veiculos[i].exibirInformacoes());
  }
  while (true) {
    final pos = lerInt('Digite o número do veículo (1 a ${veiculos.length}):');
    if (pos >= 1 && pos <= veiculos.length) return pos - 1;
    print('  Posição inválida. Digite um número entre 1 e ${veiculos.length}.');
  }
}

// ── Main ──────────────────────────────────────────────────────────────────────

void main() {
  limparTela();
  final List<Veiculo> veiculos = [];

  while (true) {
    final opcao = exibirMenu();
    limparTela();

    switch (opcao) {

      // ── 1: Cadastrar Carro ────────────────────────────────────────────────
      case 1:
        try {
          final marca         = lerTexto('Marca do veículo:');
          final modelo        = lerTexto('Modelo do veículo:');
          final valorDiaria   = lerDouble('Valor da diária (R\$):');
          final quantidade    = lerInt('Quantidade disponível:');
          final portas        = lerInt('Quantidade de portas:');

          final carro = Carro(marca, modelo, valorDiaria, quantidade, portas);
          veiculos.add(carro);

          print('\nCarro cadastrado com sucesso!');
          print(carro.exibirInformacoes());
        } on ArgumentError catch (e) {
          print('\nErro de validação: ${e.message}');
        }
        pausar();
        limparTela();

      // ── 2: Cadastrar Moto ─────────────────────────────────────────────────
      case 2:
        try {
          final marca         = lerTexto('Marca do veículo:');
          final modelo        = lerTexto('Modelo do veículo:');
          final valorDiaria   = lerDouble('Valor da diária (R\$):');
          final quantidade    = lerInt('Quantidade disponível:');
          final cilindradas   = lerInt('Quantidade de cilindradas:');

          final moto = Moto(marca, modelo, valorDiaria, quantidade, cilindradas);
          veiculos.add(moto);

          print('\nMoto cadastrada com sucesso!');
          print(moto.exibirInformacoes());
        } on ArgumentError catch (e) {
          print('\nErro de validação: ${e.message}');
        }
        pausar();
        limparTela();

      // ── 3: Listar Veículos ────────────────────────────────────────────────
      case 3:
        if (veiculos.isEmpty) {
          print('Nenhum veículo cadastrado.');
        } else {
          for (var i = 0; i < veiculos.length; i++) {
            print('\n[${i + 1}]');
            print(veiculos[i].exibirInformacoes());
          }
        }
        pausar();
        limparTela();

      // ── 4: Editar Veículo ─────────────────────────────────────────────────
      case 4:
        if (veiculos.isEmpty) {
          print('Nenhum veículo cadastrado.');
          pausar();
          limparTela();
          break;
        }

        final indexEditar = selecionarVeiculo(veiculos, 'Editar Veículo');
        final veiculoEditar = veiculos[indexEditar];
        limparTela();

        try {
          veiculoEditar.marca       = lerTexto('Nova marca do veículo:');
          veiculoEditar.modelo      = lerTexto('Novo modelo do veículo:');
          veiculoEditar.valorDiaria = lerDouble('Novo valor da diária (R\$):');
          veiculoEditar.quantidade  = lerInt('Nova quantidade disponível:');

          if (veiculoEditar is Carro) {
            veiculoEditar.quantidadePortas = lerInt('Novo número de portas:');
          } else if (veiculoEditar is Moto) {
            veiculoEditar.cilindradas = lerInt('Novo valor de cilindradas:');
          }

          print('\nVeículo editado com sucesso!');
          print(veiculoEditar.exibirInformacoes());
        } on ArgumentError catch (e) {
          print('\nErro de validação: ${e.message}');
        }
        pausar();
        limparTela();

      // ── 5: Excluir Veículo ────────────────────────────────────────────────
      case 5:
        if (veiculos.isEmpty) {
          print('Nenhum veículo cadastrado.');
          pausar();
          limparTela();
          break;
        }

        final indexExcluir = selecionarVeiculo(veiculos, 'Excluir Veículo');
        veiculos.removeAt(indexExcluir);
        print('\nVeículo excluído com sucesso!');
        pausar();
        limparTela();

      // ── 6: Alugar Veículo ─────────────────────────────────────────────────
      case 6:
        if (veiculos.isEmpty) {
          print('Nenhum veículo cadastrado.');
          pausar();
          limparTela();
          break;
        }

        final indexAlugar = selecionarVeiculo(veiculos, 'Alugar Veículo');
        limparTela();

        final dias = lerInt('Quantidade de dias:');
        final veiculoAlugar = veiculos[indexAlugar];

        try {
          final valorTotal = veiculoAlugar.alugar(dias);

          print('\nAluguel realizado com sucesso!');
          print('Veículo: ${veiculoAlugar.modelo}');
          print('Valor da diária: R\$ ${veiculoAlugar.valorDiaria.toStringAsFixed(2)}');
          print('Quantidade de dias: $dias');
          print('Valor total do aluguel: R\$ ${valorTotal.toStringAsFixed(2)}');
          print('Quantidade disponível após o aluguel: ${veiculoAlugar.quantidade}');
        } on ArgumentError catch (e) {
          print('\nOperação inválida: ${e.message}');
        } on StateError catch (e) {
          print('\nOperação inválida: ${e.message}');
        }
        pausar();
        limparTela();

      // ── 0: Sair ───────────────────────────────────────────────────────────
      case 0:
        print('Saindo...');
        return;

      default:
        print('Opção inválida. Tente novamente.');
        pausar();
        limparTela();
    }
  }
}
