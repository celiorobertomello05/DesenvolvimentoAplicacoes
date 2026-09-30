import 'package:meu_app/veiculo.dart';

class Moto extends Veiculo{
  int _cilindradas = 0;

  Moto(String placa, String modelo, double valorDiaria, int cilindradas):super(placa, modelo, valorDiaria){
    this.cilindradas = cilindradas;

  }

  int get cilindradas => _cilindradas;

set cilindradas(int novaCilindrada){
         if(novaCilindrada < 0){
             throw ArgumentError("Valor Inválido");
            } else {
            _cilindradas = novaCilindrada;
        }
    }

@override
  String exibirInformacoes() {
    return "Placa: $placa\nModelo: $modelo\nValor da Diária: $valorDiaria\nCilindradas: $cilindradas\n";
  }
  }
  