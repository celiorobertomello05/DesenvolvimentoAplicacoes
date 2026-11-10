import 'package:meu_app/veiculo.dart';

class Moto extends Veiculo {
  int _cilindradas = 0;

  Moto(
    String marca,
    String modelo,
    double valorDiaria,
    int quantidade,
    int cilindradas,
  ) : super(marca, modelo, valorDiaria, quantidade) {
    this.cilindradas = cilindradas;
  }

  // ── Getter / Setter ──────────────────────────────────────────────────────────

  int get cilindradas => _cilindradas;

  set cilindradas(int novaCilindrada) {
    if (novaCilindrada < 0) {
      throw ArgumentError("O valor de cilindradas não pode ser negativo.");
    }
    _cilindradas = novaCilindrada;
  }

  // ── Exibição ─────────────────────────────────────────────────────────────────

  @override
  String exibirInformacoes() {
    return "Marca: $marca\n"
        "Modelo: $modelo\n"
        "Valor da Diária: R\$ ${valorDiaria.toStringAsFixed(2)}\n"
        "Cilindradas: $cilindradas cc\n"
        "Quantidade disponível: $quantidade\n";
  }
}