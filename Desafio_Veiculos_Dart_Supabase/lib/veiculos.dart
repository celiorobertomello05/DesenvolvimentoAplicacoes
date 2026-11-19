import 'package:supabase/supabase.dart';

// Os 4 métodos do CRUD, feitos a partir dos antigos
// create.dart, read.dart, update.dart e delete.dart.
// Eles NÃO leem o teclado: recebem tudo por parâmetro e retornam o resultado.
// Quem lê o teclado e imprime é o bin/main.dart.
//
// Tipos de retorno (vêm do próprio pacote supabase):
// PostgrestMap  = um registro (uma linha da tabela)
// PostgrestList = uma lista de registros
// O "?" significa que pode voltar null (nenhum registro afetado).

// CREATE (era o create.dart): insere e retorna o registro com o ID do banco
Future<PostgrestMap> cadastrarVeiculo(
  SupabaseClient cliente,
  String marca,
  String modelo,
  int ano,
  double valor,
  int quilometragem,
) async {
  return await cliente
      // Seleciona a tabela
      .from("veiculos")
      // Insere dados na tabela (o id NÃO é enviado: o banco gera sozinho)
      .insert({
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
        'valor': valor,
        'quilometragem': quilometragem,
      })
      // Retorna o registro
      .select()
      // Retorna único
      .single();
}

// READ (era o read.dart): retorna os veículos ordenados pelo id
// (lista vazia se não houver nenhum)
Future<PostgrestList> listarVeiculos(SupabaseClient cliente) async {
  return await cliente
      // Define a tabela que iremos consultar
      .from("veiculos")
      // Consulta os dados
      .select("id, marca, modelo, ano, valor, quilometragem")
      // Ordenação pelo id, do menor para o maior
      // (no Dart o padrão é decrescente, por isso ascending: true)
      .order("id", ascending: true);
}

// UPDATE (era o update.dart): retorna o registro atualizado ou null
Future<PostgrestMap?> atualizarVeiculo(
  SupabaseClient cliente,
  int id,
  String marca,
  String modelo,
  int ano,
  double valor,
  int quilometragem,
) async {
  final registros = await cliente
      // Informa a tabela
      .from("veiculos")
      // Método para atualizar (o id NÃO é alterado)
      .update({
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
        'valor': valor,
        'quilometragem': quilometragem,
      })
      // Identificador
      .eq("id", id)
      // Retorna os valores atualizados (lista com 0 ou 1 registro)
      .select();

  // Lista vazia = nenhuma linha afetada (ID não existe)
  if (registros.isEmpty) {
    return null;
  }
  return registros.first;
}

// DELETE (era o delete.dart): retorna o registro removido ou null
Future<PostgrestMap?> excluirVeiculo(SupabaseClient cliente, int id) async {
  final registros = await cliente
      .from("veiculos")
      .delete()
      // Identificador: só exclui esse id
      .eq("id", id)
      // Retorna o registro removido (lista com 0 ou 1 registro)
      .select();

  // Lista vazia = nenhuma linha afetada (ID não existe)
  if (registros.isEmpty) {
    return null;
  }
  return registros.first;
}
