void main() {
// variavel pode ser reatribuida
  var nome = ["Willian", "Oliveira"];

  print(nome.runtimeType);

  var id = {1, 2};
  print(id.runtimeType);

  var idades = {"Joao": 10, "Kleber": 20};
  print(idades.runtimeType);

  //final - variavel nao pode ser reatribuida
  final nomes2 = ["joao", "roberto"];
  //nome2 = ["Pedro"]; nao pode reatribuir valor

  //const - nao permite adicao de novos valores

  const frutas = ["maca"];
  //frutas.add("banana");

  //listas dinamicas

  List<dynamic> valores = ["pedro", 10, false, 0.1];

  print(valores);
}
