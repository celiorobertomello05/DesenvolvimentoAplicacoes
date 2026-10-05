import 'package:interact/interact.dart';
import 'package:meu_app/carro.dart';
import 'package:meu_app/moto.dart';
import 'package:meu_app/veiculo.dart';

import 'dart:io';

void limparTela() {
  print('\x1B[2J\x1B[0f');
}

void main() {
  limparTela();
  List<Veiculo> veiculos = [];

  while (true) {
    final options = [
      'Cadastrar Carro',
      'Cadastrar Moto',
      'Listar Veiculos',
      'Editar Veiculo',
      'Excluir Veiculo',
      'Sair',
    ];

    final index = Select(
      prompt: "Agencia de Carros do Celio",
      options: options,
    ).interact();

    limparTela();

    if (index == 0) {
      print("Digite a placa do veiculo");
      String placa = stdin.readLineSync()!;

      print("Digite o Modelo do Veiculo");
      String modelo = stdin.readLineSync()!;

      print("Digite o valor da Diária");
      double novoValorDiaria = double.parse(stdin.readLineSync()!);

      print("Digite a quantidade de portas");
      int novoQuantidadePortas = int.parse(stdin.readLineSync()!);

      Carro carro = Carro(placa, modelo, novoValorDiaria, novoQuantidadePortas);

      veiculos.add(carro);

      print("\nVeiculo cadastrado com sucesso!");
      print(carro.exibirInformacoes());

      stdin.readLineSync();
      limparTela();
    } else if (index == 1) {
      print("Digite a placa do veiculo");
      String placa = stdin.readLineSync()!;

      print("Digite o Modelo do Veiculo");
      String modelo = stdin.readLineSync()!;

      print("Digite o valor da Diária");
      double novoValorDiaria = double.parse(stdin.readLineSync()!);

      print("Digite a quantidade de cilindradas");
      int novaCilindradas = int.parse(stdin.readLineSync()!);

      Moto moto = Moto(placa, modelo, novoValorDiaria, novaCilindradas);

      veiculos.add(moto);

      print("\nMoto cadastrada com sucesso!");
      print(moto.exibirInformacoes());
      stdin.readLineSync();
      limparTela();
    } else if (index == 2) {
      if (veiculos.isEmpty) {
        print("Nenhuma informação encontrada");
        stdin.readLineSync();
        limparTela();

        continue;
      }
      for (var veiculo in veiculos) {
        print(veiculo.exibirInformacoes());
      }
      stdin.readLineSync();
      limparTela();
    } else if (index == 3) {
      if (veiculos.isEmpty) {
        print("Nenhum veículo cadastrado.");
        stdin.readLineSync();
        limparTela();

        continue;
      }

      List<String> opcoesEditar = [];
      for (var veiculo in veiculos) {
        opcoesEditar.add(veiculo.exibirInformacoes());
      }

      final indexEditar = Select(
        prompt: "Selecione um veiculo para Editar",
        options: opcoesEditar,
      ).interact();

      Veiculo veiculo = veiculos[indexEditar];

      print("Digite a nova placa do veiculo");
      veiculo.placa = stdin.readLineSync()!;

      print("Digite o novo Modelo do Veiculo");
      veiculo.modelo = stdin.readLineSync()!;

      print("Digite o novo valor da Diária");
      veiculo.valorDiaria = double.parse(stdin.readLineSync()!);

      if (veiculo is Carro) {
        print("Digite o novo numero de portas");
        veiculo.quantidadePortas = int.parse(stdin.readLineSync()!);
      } else if (veiculo is Moto) {
        print("Digite o novo valor de cilindradas");
        veiculo.cilindradas = int.parse(stdin.readLineSync()!);
      }
      print("\nVeiculo editado com sucesso!");
      print(veiculo.exibirInformacoes());

      stdin.readLineSync();
      limparTela();
    } else if (index == 4) {
      if (veiculos.isEmpty) {
        print("Nenhum veículo cadastrado.");
        stdin.readLineSync();
        limparTela();

        continue;
      }

      List<String> opcoesVeiculos = [];
      for (var veiculo in veiculos) {
        opcoesVeiculos.add(veiculo.exibirInformacoes());
      }
      final indexOpcaoVeiculo = Select(
        prompt: "Selecione o veiculo para excluir",
        options: opcoesVeiculos,
      ).interact();
      veiculos.removeAt(indexOpcaoVeiculo);

      print("\nVeiculo excluido com sucesso!");

      stdin.readLineSync();
      limparTela();
    } else if (index == 5) {
      print("Saindo...");
      break;
    }
  }
}
