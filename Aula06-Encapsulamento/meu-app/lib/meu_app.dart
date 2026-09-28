class Produto{
  String _nome = "";
  double _valor = 0;
  int _quantidade = 0;

  Produto( String nome, double valor, int quantidade){
    this.nome = nome;
    this.valor = valor;
    this.quantidade = quantidade;
  }

  //getters
  // String get nome => _quantidade;
  String get nome{
    return _nome;
  }
  
  double get valor{
    return _valor;
  }
  
  int get quantidade{
    return _quantidade;
  }
  // Setters
  set nome(String novoNome){
    if (novoNome.isEmpty){
      throw ArgumentError("Valor Inválido");
    } else{
      _nome= novoNome;
    }
  }

  set valor( double novoValor){
    if(novoValor < 0){
      throw ArgumentError("Valor Inválido");
    } else {
      _valor = novoValor;
    }
  }
  set quantidade ( int novaQuantidade ){
    if(novaQuantidade < 0){
      throw ArgumentError("Valor Inválido");
    } else {
      _quantidade = novaQuantidade;
    }
  }
}