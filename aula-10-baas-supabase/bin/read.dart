import '../lib/conexao.dart';

main() async {
  final supabase = conexao();

  try {
    final produtos = await supabase
        ///Definir a tabela que iremos consultar
        .from("produtos")
        //Consultar os dados
        .select("id, nome, preco, quantidade")
        //ordernação pelo id
        .order("id");

    if (produtos.isEmpty) {
      print("Nenhum produto cadastrado");
      return;
    }
    for (final produto in produtos) {
      print("ID: ${produto['id']}");
      print("NOME: ${produto["nome"]}");
      print("PRECO: ${produto['preco']}");
      print("QUANTIDADE: ${produto['quantidade']}");
      final valorTotal = produto['preco'] * produto['quantidade'];
      print("Valor Total: R\$ ${valorTotal}");
    }
  } catch (erro) {
    print(erro);
  } finally {
    await supabase.dispose();
  }
}
