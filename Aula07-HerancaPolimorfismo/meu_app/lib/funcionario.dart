abstract class Funcionario {
  String _nome = "";
  double _salario = 0;

  //Construtor
  Funcionario(String nome, double salario){
    this.nome = nome;
    this.salario = salario;
  }

  //Getters 
  String get nome {
    return _nome;
  }

  double get salario {
    return _salario;
  }

  //Setters
  set nome(String novoNome){
    if (novoNome.trim().isEmpty){
      throw ArgumentError("O nome não pode estar vazio");
    }
      _nome = novoNome;
  }

  set salario(double novoSalario){
    if (novoSalario < 0) {
      throw ArgumentError("O salário deve ser maior que zero");
    }
    _salario = novoSalario;
  }

  //Exibir informação do funcionário

  String exibirInformacoes(){
    return ("Nome:  $nome, Salario $salario");
  }

}
