class IMCCalculo {
  double _peso = 0;
  double _altura = 0;
  double imc = 0;

//Get and Set!
  set peso(double peso) {
    _peso = peso;
  }

  double get peso => _peso;

  set altura(double altura) {
    _altura = altura;
  }

  double get altura => _altura;

//Calculate
  double Calculo(double? peso, double? altura) {
    imc = (peso! / (altura! * altura));
    return imc;
  }

  String Situacao(imc) {
    if (imc < 16) {
      return "Magreza Grave";
    } else if ((imc >= 16) && (imc < 17)) {
      return "Magreza Moderada";
    } else if ((imc >= 17) && (imc < 18.5)) {
      return "Magreza Leve";
    } else if ((imc >= 18.5) && (imc < 25)) {
      return "Saúdavel";
    } else if ((imc >= 25) && (imc < 30)) {
      return "Sobrepeso";
    } else if ((imc >= 30) && (imc < 35)) {
      return "Obesidade Grau I";
    } else if ((imc >= 35) && (imc < 40)) {
      return "Obesidade Grau II (severa)";
    } else {
      return "Obesidade Grau III (mórbida)";
    }
  }
}
