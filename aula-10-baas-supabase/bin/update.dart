import 'package:app_crudsupa/conexao.dart';

import 'dart:io';

main() async {
  final supabase = conexao();

  try {
    print("Digite o ID do produtor que deseja alterar: ");
    final id = int.parse(stdin.readLineSync()!);

    print("Digite o novo nome do produtor que deseja alterar: ");
    final nome = (stdin.readLineSync()!);

    print("Digite o preco do produtor que deseja alterar: ");
    final preco = double.parse(stdin.readLineSync()!);

    print("Digite o novo nome do produto que deseja alterar: ");
    final quantidade = int.parse(stdin.readLineSync()!);

    final produto = await supabase
        //informar a tabela
      .from("produtos")
    //metodo para atualizar
      .update({
        "nome": nome, 
        "preco": preco, 
        "quantidade": quantidade})

          //Identificador
          .eq("id", id)
          //retornar os valores atualizados
          .select()
          .single();

      print(produto);
      print("Atualização feita com sucesso");


    } catch (erro) {
      print(erro);
    } finally {
      await supabase.dispose();
    }
  }
