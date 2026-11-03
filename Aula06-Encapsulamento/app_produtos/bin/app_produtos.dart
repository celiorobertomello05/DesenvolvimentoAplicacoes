import 'package:app_produtos/app_produtos.dart';

void main(){
  
  try{
  Produto camisa = Produto("Camisa", -100, -10);

  print(camisa.nome);
  print(camisa.quantidade);
  print(camisa.valor);

//Utilizando Setters para alterar os valores

camisa.nome = "Tênis";
camisa.quantidade = 101;
camisa.valor = 300;

  print(camisa.nome);
  print(camisa.quantidade);
  print(camisa.valor);




  } catch (erro) {
    print(erro);
  }

}