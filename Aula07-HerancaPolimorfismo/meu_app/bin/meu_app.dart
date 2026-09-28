import '../lib/estagiario.dart';
import '../lib/funcionario.dart';
import '../lib/gerente.dart';
import '../lib/vendedor.dart';

void main() {
  Funcionario gerente = Gerente("João", 1500, "Vendas");
  Funcionario estagiario = Estagiario("Jose", 1200, "Engenharia de Software");
  Funcionario vendedor = Vendedor("Jorje", 2200, 10000);

  print(gerente.exibirInformacoes());
  print(estagiario.exibirInformacoes());
  print(vendedor.exibirInformacoes());
}
