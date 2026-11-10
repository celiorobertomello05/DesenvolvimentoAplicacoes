void main() {
  //listas
  List<String> listarNomes = ["Roberto", "Celio"];
  print(listarNomes);
  print(listarNomes[1]);
  print("Primeiro nome ${listarNomes[1]}");

  //set > ignora duplicidade

  Set<String> listarCores = {"Azul", "Vermelho", "Azul"};
  print(listarCores);

  //map > chave - valor

  Map<String, int> listarIdades = {"Ana": 50, "José": 20};

  print(listarIdades);
  print(listarIdades.values);
  print(listarIdades.keys);
  
    Map<String,String> listar = {"Ana": "Maria", "José": "Augusto"};
    print(listar);
}
