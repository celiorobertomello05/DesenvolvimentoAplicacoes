import 'package:meu_app/meu_app.dart';

void main() {

  try{
  Produto camisa = Produto("Camisa", -100, -1000);
  print(camisa.nome);
  print(camisa.valor);
  print(camisa.quantidade);

  camisa.nome = "Tenis";
  camisa.valor = 100.00;
  camisa.quantidade = 5;
  } catch (erro){
    print(erro);
  }
}
