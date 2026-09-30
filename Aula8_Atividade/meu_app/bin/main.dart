import 'package:meu_app/carro.dart';
import 'package:meu_app/moto.dart';

void main() {
  Carro c1 = Carro("GHJK-4055", "Carro Genérico", 200, 4);
  print(c1.exibirInformacoes());

  Moto m1 = Moto("GHJK-8055", "Moto Genérica", 70, 60);
  print(m1.exibirInformacoes());
}
