import 'package:meu_app/bonificavel.dart';

import 'funcionario.dart';

class Gerente extends Funcionario implements Bonificavel{

  String _setor = "";

  Gerente(String nome, double salario, String setor) : super(nome, salario){
    this.setor = setor;
  }

  @override
  double calcularBonificacao(){
    return salario *0.05;
  }
  String get setor {
    return _setor;
  }

  set setor(String novoSetor){
    if(novoSetor.trim().isEmpty){
      throw ArgumentError("Nome do setor não pode estar vazio");
    }
    _setor = novoSetor;
  }
  @override
  String exibirInformacoes(){
    return super.exibirInformacoes() + ", Setor: $setor , Bonificação ${calcularBonificacao()}";
  }

} 