//registrar informações no banco de dados
import '../lib/conexao.dart';

main() async {
  //conexao
  final supabase = conexao();

  try {
    final produto = await supabase
        //Seleciona a tabela
        .from("produtos")
        //Inseri dados na tabela
        .insert({'nome': 'Computador', 'preco': 150.00, 'quantidade': 10})
        //Retorna o registro
        .select()
        //Retorna único
        .single();

    print(produto);
  } catch (erro, stackTrace) {
    print("Ocorreu o seguinte erro: $erro");
    print(stackTrace);
  } finally {
    //Encerra a conexão

    await supabase.dispose();
  }
}
