import '../lib/conexao.dart';

import 'dart:io';

main() async {
  final supabase = conexao();

  //Informe id
  try {
    print("Digite o ID do Produto a ser excluído");
    final id = int.parse(stdin.readLineSync()!);

    final produto = await supabase
        .from("produtos")
        .delete()
        .eq("id", id)
        .select()
        .single();

  } catch (erro) {
    print("A vaca foi pro brejo $erro");
    
  } finally {
    await supabase.dispose();
  }
}
