import 'funcionario.dart';

class Estagiario extends Funcionario{

  String _curso = "";

  Estagiario (String nome, double salario, String curso) : super(nome, salario){
    this.curso = curso;
  }

  //Getters
  String get curso{
    return _curso;
  } 

  //Setters
  set curso (String novoCurso){
    if(novoCurso.trim().isEmpty){
      throw ArgumentError("Curso está vazio");
    }
    _curso = novoCurso;
  }
  
  @override
  String exibirInformacoes(){
    return super.exibirInformacoes() + ", Curso: $curso";
  }
}