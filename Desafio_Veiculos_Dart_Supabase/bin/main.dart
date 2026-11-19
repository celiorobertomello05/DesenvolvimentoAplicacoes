import 'dart:io';
import 'package:supabase/supabase.dart';
import 'package:app_crudsupa/conexao.dart';
import 'package:app_crudsupa/veiculos.dart';

// ── Leitura do teclado ──
// Cada função lê uma entrada e, se for inválida, lança ArgumentError
// com o motivo. O menu captura o erro e volta ao início.

// Lê uma linha (se vier nula, vira texto vazio)
String lerTexto(String pergunta) {
  stdout.write("$pergunta: ");
  return (stdin.readLineSync() ?? "").trim();
}

// Lê um inteiro com tryParse (retorna null se não for número)
int lerInteiro(String pergunta, String campo) {
  final numero = int.tryParse(lerTexto(pergunta));
  if (numero == null) {
    throw ArgumentError("$campo deve ser um número inteiro.");
  }
  return numero;
}

// Lê o ID: inteiro positivo
int lerId() {
  final id = lerInteiro("ID do veículo", "O ID");
  if (id <= 0) {
    throw ArgumentError("O ID deve ser um número inteiro positivo.");
  }
  return id;
}

// ── Validação dos campos ──

// Marca e modelo: sem espaços nas pontas, não vazio, com limite de caracteres
String lerNome(String pergunta, String campo, int limite) {
  final texto = lerTexto(pergunta); // lerTexto já faz o trim()
  if (texto.isEmpty) {
    throw ArgumentError("O campo $campo não pode ficar vazio.");
  }
  if (texto.length > limite) {
    throw ArgumentError("O campo $campo deve ter no máximo $limite caracteres.");
  }
  return texto;
}

// Ano: inteiro entre 1900 e o ano atual + 1
int lerAno(String pergunta) {
  final ano = lerInteiro(pergunta, "O ano");
  final anoMaximo = DateTime.now().year + 1;
  if (ano < 1900 || ano > anoMaximo) {
    throw ArgumentError("O ano deve estar entre 1900 e $anoMaximo.");
  }
  return ano;
}

// Valor: aceita vírgula ou ponto, até 2 casas, sem separador de milhar
double lerValor(String pergunta) {
  final texto = lerTexto(pergunta);
  // Só dígitos, com no máximo 2 casas depois da vírgula/ponto
  if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
    throw ArgumentError("Valor inválido. Use até 2 casas (ex.: 65000,00).");
  }
  final valor = double.parse(texto.replaceAll(',', '.'));
  if (!valor.isFinite || valor <= 0 || valor >= 10000000000) {
    throw ArgumentError("O valor deve ser maior que zero e menor que 10000000000.");
  }
  return valor;
}

// Quilometragem: inteiro maior ou igual a zero (zero = veículo sem uso)
int lerQuilometragem(String pergunta) {
  final km = lerInteiro(pergunta, "A quilometragem");
  if (km < 0) {
    throw ArgumentError("A quilometragem não pode ser negativa.");
  }
  return km;
}

// ── Opções do menu ──
Future<void> cadastrar(SupabaseClient cliente) async {
  final marca = lerNome("Marca", "marca", 50);
  final modelo = lerNome("Modelo", "modelo", 100);
  final ano = lerAno("Ano");
  final valor = lerValor("Valor");
  final km = lerQuilometragem("Quilometragem");

  final v = await cadastrarVeiculo(cliente, marca, modelo, ano, valor, km);
  print("Veículo cadastrado!");
  print("ID: ${v['id']} | ${v['marca']} ${v['modelo']} | Ano: ${v['ano']} | "
      "Valor: R\$ ${v['valor'].toStringAsFixed(2)} | "
      "Quilometragem: ${v['quilometragem']} km");
}

Future<void> listar(SupabaseClient cliente) async {
  final veiculos = await listarVeiculos(cliente);
  if (veiculos.isEmpty) {
    print("Nenhum veículo cadastrado.");
    return;
  }
  for (final v in veiculos) {
    print("ID: ${v['id']} | Marca: ${v['marca']} | Modelo: ${v['modelo']}");
    print("Ano: ${v['ano']} | Valor: R\$ ${v['valor'].toStringAsFixed(2)}");
    print("Quilometragem: ${v['quilometragem']} km\n");
  }
}

Future<void> atualizar(SupabaseClient cliente) async {
  final id = lerId();
  final marca = lerNome("Nova marca", "marca", 50);
  final modelo = lerNome("Novo modelo", "modelo", 100);
  final ano = lerAno("Novo ano");
  final valor = lerValor("Novo valor");
  final km = lerQuilometragem("Nova quilometragem");

  final v = await atualizarVeiculo(cliente, id, marca, modelo, ano, valor, km);
  // null = nenhum registro foi afetado
  if (v == null) {
    print("Nenhum veículo encontrado com o ID $id.");
    return;
  }
  print("Veículo atualizado!");
  print("ID: ${v['id']} | ${v['marca']} ${v['modelo']} | Ano: ${v['ano']} | "
      "Valor: R\$ ${v['valor'].toStringAsFixed(2)} | "
      "Quilometragem: ${v['quilometragem']} km");
}

Future<void> excluir(SupabaseClient cliente) async {
  final id = lerId();
  final resposta = lerTexto("Confirma a exclusão? S/N");

  if (resposta == "N" || resposta == "n") {
    print("Exclusão cancelada.");
    return;
  }
  if (resposta != "S" && resposta != "s") {
    print("Resposta inválida. Nada foi excluído.");
    return;
  }

  final removido = await excluirVeiculo(cliente, id);
  if (removido == null) {
    print("Nenhum veículo encontrado com o ID $id.");
    return;
  }
  print("Veículo excluído!");
  print("ID: ${removido['id']} | ${removido['marca']} ${removido['modelo']}");
}

void main() async {
  // Cria o cliente uma vez e reaproveita enquanto o menu estiver ativo
  final cliente = conectar();
  String opcao = "";

  try {
    // Repete enquanto a opção NÃO for 0
    while (opcao != "0") {
      print("\nCADASTRO DE VEÍCULOS");
      print("1 - Cadastrar veículo");
      print("2 - Listar veículos");
      print("3 - Atualizar veículo");
      print("4 - Excluir veículo");
      print("0 - Sair");
      opcao = lerTexto("O que deseja fazer?");

      // try/catch dentro do while: se falhar, mostra o erro e volta ao menu
      try {
        switch (opcao) {
          case "1":
            await cadastrar(cliente);
          case "2":
            await listar(cliente);
          case "3":
            await atualizar(cliente);
          case "4":
            await excluir(cliente);
          case "0":
            print("Sistema encerrado.");
          default:
            print("Opção inválida. Tente novamente.");
        }
      } on ArgumentError catch (erro) {
        // Erro de validação (setter ou leitura): mostra só o motivo
        print("${erro.message}");
      } catch (erro) {
        // Qualquer outro erro (ex.: banco)
        print("Ocorreu o seguinte erro: $erro");
      }
    }
  } finally {
    // Encerra a conexão
    await cliente.dispose();
  }
}
