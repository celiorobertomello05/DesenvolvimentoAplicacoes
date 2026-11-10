import 'package:meu_app/veiculo.dart';

class Carro extends Veiculo {
  int _quantidadePortas = 0;

  Carro(
    String marca,
    String modelo,
    double valorDiaria,
    int quantidade,
    int quantidadePortas,
  ) : super(marca, modelo, valorDiaria, quantidade) {
    this.quantidadePortas = quantidadePortas;
  }

  // ── Getter / Setter ──────────────────────────────────────────────────────────

  int get quantidadePortas => _quantidadePortas;

  set quantidadePortas(int novaQuantidade) {
    if (novaQuantidade < 0) {
      throw ArgumentError("A quantidade de portas não pode ser negativa.");
    }
    _quantidadePortas = novaQuantidade;
  }

  // ── Exibição ─────────────────────────────────────────────────────────────────

  @override
  String exibirInformacoes() {
    return "Marca: $marca\n"
        "Modelo: $modelo\n"
        "Valor da Diária: R\$ ${valorDiaria.toStringAsFixed(2)}\n"
        "Quantidade de Portas: $quantidadePortas\n"
        "Quantidade disponível: $quantidade\n";
  }
}