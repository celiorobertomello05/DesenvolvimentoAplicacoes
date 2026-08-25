
import 'dart:developer';

void main(){
  Filme odisseia = Filme();
 /* odisseia.titulo = "Odisseia";
  odisseia.genero = "Drama/Aventura";
  odisseia.sinopse = """A Odisseia (The Odyssey), dirigido por Christopher Nolan, acompanha o lendário guerreiro grego Odisseu (Matt Damon) em sua perigosa e longa jornada de volta para casa em Ítaca,
                        após a vitória na Guerra de Troia. Lutando para se reunir com sua esposa, Penélope (Anne Hathaway), 
                        ele enfrenta criaturas míticas, a fúria dos deuses e os limites da própria resistência. Classificação indicativa 14 Anos.
                        Contém violência.""";
  odisseia.classificacao = 14;
  odisseia.duracao = 172;
  odisseia.exibirFilme();*/


}


//Criação de Classes
class Filme{

  //Definição de atributos 
  String titulo;
  String genero;
  String sinopse;
  int classificacao;
  int duracao;

/*Construtor
  Filme(
    this.titulo,
    this.genero,
    this.sinopse,
    this.classificacao,
    this.duracao

  );*/

  //Construtor - Parametros Nomeados
  Filme( {
    required this.titulo,
    required this.genero,
    required this.sinopse,
    required this.classificacao,
    required this.duracao

});






  
//Criação de Metodos
  void exibirFilme(){
    print ("O titulo do Filme $titulo");
    print ("O gênero do Filme $genero");
    print("Sinopse:  $sinopse");
    print ("A classificacão do Filme é $classificacao");
    print ("A duração do Filme $duracao");
  }

}


