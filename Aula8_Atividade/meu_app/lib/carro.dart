import 'package:meu_app/veiculo.dart';

class Carro extends Veiculo{
  int _quantidadePortas = 0;

  Carro(String placa, String modelo, double valorDiaria, int quantidadePortas):super(placa, modelo, valorDiaria){
    this.quantidadePortas = quantidadePortas;

  }

int get quantidadePortas => _quantidadePortas;

set quantidadePortas(int novaQuantidadePorta){
         if(novaQuantidadePorta < 0){
             throw ArgumentError("Valor Inválido");
            } else {
            _quantidadePortas = novaQuantidadePorta;
        }
    }

  @override
  String exibirInformacoes() {
    return "Placa: $placa\n, Modelo: $modelo\n,Valor da Diária $valorDiaria\n,Quantidade de Portas: $quantidadePortas\n";
  }
  }

