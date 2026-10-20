abstract class Veiculo {
  String _marca = "";
  String _modelo = "";
  double _valorDiaria = 0;
  int _quantidade = 0;

  Veiculo(String marca, String modelo, double valorDiaria, int quantidade) {
    this.marca = marca;
    this.modelo = modelo;
    this.valorDiaria = valorDiaria;
    this.quantidade = quantidade;
  }

  // ── Getters ─────────────────────────────────────────────────────────────────

  String get marca => _marca;
  String get modelo => _modelo;
  double get valorDiaria => _valorDiaria;
  int get quantidade => _quantidade;

  // ── Setters ─────────────────────────────────────────────────────────────────

  set marca(String novaMarca) {
    if (novaMarca.isEmpty) {
      throw ArgumentError("A marca não pode ser vazia.");
    }
    _marca = novaMarca;
  }

  set modelo(String novoModelo) {
    if (novoModelo.isEmpty) {
      throw ArgumentError("O modelo não pode ser vazio.");
    }
    _modelo = novoModelo;
  }

  set valorDiaria(double novoValor) {
    // Desafio exige valor MAIOR que zero (não apenas não-negativo)
    if (novoValor <= 0) {
      throw ArgumentError("O valor da diária deve ser maior que zero.");
    }
    _valorDiaria = novoValor;
  }

  set quantidade(int novaQuantidade) {
    if (novaQuantidade < 0) {
      throw ArgumentError("A quantidade não pode ser negativa.");
    }
    _quantidade = novaQuantidade;
  }

  // ── Método de aluguel ────────────────────────────────────────────────────────

  /// Realiza o aluguel de uma unidade por [dias] dias.
  /// Retorna o valor total cobrado.
  /// Lança [ArgumentError] se os dias forem inválidos.
  /// Lança [StateError] se não houver unidades disponíveis.
  double alugar(int dias) {
    if (dias <= 0) {
      throw ArgumentError("A quantidade de dias deve ser maior que zero.");
    }
    if (_quantidade <= 0) {
      throw StateError("Não há unidades disponíveis para este veículo.");
    }

    double total = _valorDiaria * dias;
    _quantidade--; // reduz diretamente o campo privado — acesso interno é válido
    return total;
  }

  // ── Exibição ─────────────────────────────────────────────────────────────────

  String exibirInformacoes() {
    return "Marca: $marca\n"
        "Modelo: $modelo\n"
        "Valor da Diária: R\$ ${valorDiaria.toStringAsFixed(2)}\n"
        "Quantidade disponível: $quantidade\n";
  }
}