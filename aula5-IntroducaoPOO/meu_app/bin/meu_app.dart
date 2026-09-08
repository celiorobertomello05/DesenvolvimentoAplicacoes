void main() {
  Roupa roupa1  = Roupa("Camisa", 80.50, 10);
  print(roupa1.camisaInfo());
  roupa1.decrementaRoupa(1);
  print(roupa1.camisaInfo());
  roupa1.incrementarRoupa(2);
  print(roupa1.camisaInfo());
  roupa1.valorTotal();
  print(roupa1.valorTotal());



}


class Roupa {
  //Atributos
  // Tipo nome
  String tipo;
  double valor;
  int quantidade;


//Construtor
  
    Roupa(  
    this.tipo,
    this.valor,
    this.quantidade

    );


    //Métodos
    //Adicionar e remover camisas do estoque
    void decrementaRoupa(int quantidade){

      if (quantidade > 0 && this.quantidade >= quantidade){
        this.quantidade -= quantidade;
        print("Quantidade retirada de $quantidade unidades");
    } else{
      print("Quantidade inválida");
    }
  } 

    void incrementarRoupa(int quantidade){

      if (quantidade > 0 ){
      this.quantidade += quantidade;
      print("Inserido com sucesso");
      } else{
        print("Quantidade inválida");
      }
  } 


    double valorTotal(){
      double valorTotal = valor * quantidade;
      return valorTotal;
    }

 String camisaInfo(){
    return "Tipo: $tipo\n"
           "Valor: R\$ $valor\n"
           "Quantidade: $quantidade";
    
  }

}


