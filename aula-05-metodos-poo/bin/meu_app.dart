void main() {

  Roupa camisa = Roupa(
    tipo: "Camisa de Manga Comprida",
    valor: 100.00,
    quantidade: 10,
  );
  print(camisa.camisaInfo());
  camisa.decrementarCamisa(5);
  print(camisa.camisaInfo());
  camisa.incrementarCamisa(6);
    print(camisa.camisaInfo());
}

class Roupa {
  String tipo;
  double valor;
  int quantidade;

  Roupa({
    required this.tipo, 
    required this.valor, 
    required this.quantidade
  });
  double valorTotal(){
    double valorTotal = valor * quantidade;
    return valorTotal;
  }
  void decrementarCamisa(int quantidade){
    //this faz referencia ao atributo quantidade
    if(quantidade > 0 && this.quantidade >= quantidade){
      // -= ele faz o seguinte this.quantidade = this.quantidade - quantidade
      this.quantidade -= quantidade;
      print("Quantidade retirada de  $quantidade unidades");
    } else{
      print("Quantidade inválida");
    }
  }

  void incrementarCamisa(int quantidade){
    if(quantidade >0 ){
      this.quantidade += quantidade;
      print("Quantidade de $quantidade unidades, foram adicionadas ao estoque");
    } else{
      print("Quantidade Inválida");
    }
  }
  String camisaInfo() {
    return "O tipo de Camisa é $tipo\n valor é de R\$ $valor reais \n quantidade é de $quantidade quantidades\n valor total do estoque ${valorTotal()}";
  }
}
