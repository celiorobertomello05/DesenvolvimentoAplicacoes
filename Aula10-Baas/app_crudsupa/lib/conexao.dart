import "package:supabase/supabase.dart";
import "package:dotenv/dotenv.dart";

//Função Conexão entre o Dart e o Supabase
SupabaseClient conexao() {
  final env = DotEnv()..load();
  final url = env['SUPABASE_URL'] ?? '';
  final chave = env['SUPABASE_PUBLISHABLE_KEY'] ?? '';

  if (url.isEmpty || chave.isEmpty) {
    throw StateError('Preencha a URL e a Chave');

  }

  return SupabaseClient(url, chave);
}
