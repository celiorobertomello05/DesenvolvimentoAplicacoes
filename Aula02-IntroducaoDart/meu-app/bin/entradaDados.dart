import 'dart:io';
void main(){
  print("""
░███████   ░██           ░██   ░██                                                                                                              
░██   ░██                      ░██                                                                                                              
░██    ░██ ░██ ░████████ ░██░████████  ░███████      ░███████   ░███████  ░██    ░██    ░████████   ░███████  ░█████████████   ░███████         
░██    ░██ ░██░██    ░██ ░██   ░██    ░██    ░██    ░██        ░██    ░██ ░██    ░██    ░██    ░██ ░██    ░██ ░██   ░██   ░██ ░██    ░██ ░██    
░██    ░██ ░██░██    ░██ ░██   ░██    ░█████████     ░███████  ░█████████ ░██    ░██    ░██    ░██ ░██    ░██ ░██   ░██   ░██ ░█████████        
░██   ░██  ░██░██   ░███ ░██   ░██    ░██                  ░██ ░██        ░██   ░███    ░██    ░██ ░██    ░██ ░██   ░██   ░██ ░██               
░███████   ░██ ░█████░██ ░██    ░████  ░███████      ░███████   ░███████   ░█████░██    ░██    ░██  ░███████  ░██   ░██   ░██  ░███████  ░██    
                     ░██                                                                                                                        
               ░███████                                                                                                                         
                                                                                                                                                                                                        
""");
  //? - indica que a variavel nome aceita valores nulos
  String? nome = stdin.readLineSync();
  int idade = int.parse(stdin.readLineSync()!);
  double altura = double.parse(stdin.readLineSync()!);
  print("Seu nome é $nome");
  print("Seu idade é $idade");
  print("Sua altura é $altura");
  print("Fim ");
}
