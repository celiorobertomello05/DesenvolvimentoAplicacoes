void main() {
  Filme homemaranha  = Filme(
    titulo: "Homem Aranha: Um Novo Dia",
    genero: "Açâo",
    classificacao: 12,
    duracao: 142
    
  );

  homemaranha.exibirInfo();
}

//criacao das classes

class Filme{
  //definicao dos atributos
  String titulo;
  String genero;
  int classificacao;
  int duracao; 

//Construtor - Parametros Nomeados
  Filme({
    required this.titulo,
    required this.genero,
    required this.classificacao,
    required this.duracao
});

  void exibirInfo(){
    print("O titulo do Filme é: $titulo");
    print("Genero do Filme é: $genero");
    print("A classificacao é: $classificacao anos");
    print("A duracao é de: $duracao min");
  }

}
