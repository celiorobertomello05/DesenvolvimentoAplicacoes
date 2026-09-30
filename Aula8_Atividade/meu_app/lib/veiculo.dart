abstract class Veiculo{
     String _placa = "";
     String _modelo = "";
     double _valorDiaria = 0;


    Veiculo (String placa, String modelo, double valorDiaria){
        this.placa = placa;
        this.modelo = modelo;
        this.valorDiaria = valorDiaria;
    }
    
    String get placa => _placa;

    String get modelo => _modelo;

    double get valorDiaria => _valorDiaria;

    set placa(String novaPlaca){
        if(novaPlaca.isEmpty){
            throw ArgumentError("Valor Inválido");            
        }else {
            _placa = novaPlaca;
        }
    }

    set modelo(String novoModelo){
        if(novoModelo.isEmpty){
            throw ArgumentError("Valor Inválido");
        }else{
            _modelo = novoModelo;
        }
    }

    set valorDiaria(double novoValorDiaria){
         if(novoValorDiaria < 0){
             throw ArgumentError("Valor Inválido");
            } else {
            _valorDiaria = novoValorDiaria;
        }
    }

    String exibirInformacoes(){
      return "Placa: $placa\nModelo: $modelo\n,Valor da Diária: $valorDiaria\n"; 
    }
    
    }