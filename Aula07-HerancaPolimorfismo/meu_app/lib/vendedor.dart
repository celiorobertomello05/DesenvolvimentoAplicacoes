import 'package:meu_app/bonificavel.dart';

import 'funcionario.dart';

class Vendedor extends Funcionario implements Bonificavel{

  double _metaVendas = 0;

  Vendedor(String nome, double salario, double metaVendas) : super(nome, salario){
    this.metaVendas = metaVendas;
  }
  @override
  double calcularBonificacao(){
    return salario * 0.02;
  }

  //Getters
  double get metaVendas{
    return _metaVendas; 
  }

  //Setters
  set metaVendas(double novaMetaVendas){
    if (novaMetaVendas < 0){
      throw ArgumentError("Meta não pode ser menor que zero");
    }

    _metaVendas = novaMetaVendas;
  }

  @override
  String exibirInformacoes(){
    return super.exibirInformacoes() + ", Meta de Vendas: $metaVendas, Bonificação: ${calcularBonificacao()}";
  }
}