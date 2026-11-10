# Aula 10 — BaaS com Supabase

**Assunto:** uso de um Backend as a Service (Supabase) a partir do Dart, com as quatro operações de um CRUD na tabela `produtos`:

- `bin/create.dart`: insere um produto;
- `bin/read.dart`: lista os produtos;
- `bin/update.dart`: altera um produto pelo ID;
- `bin/delete.dart`: exclui um produto pelo ID.

A conexão fica em `lib/conexao.dart` e lê a URL e a chave de um arquivo `.env` (que não vai para o GitHub).

## Como rodar

1. Copie `.env.example` para `.env` e preencha com os dados do seu projeto Supabase.
2. Rode:

```bash
dart pub get
dart run bin/create.dart
dart run bin/read.dart
```
