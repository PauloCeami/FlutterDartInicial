void main() {
  print(somar(5, 3, () {
    print("inicialiando soma passando isValid...");
  }, isvalid: false));

  print("******************************");

  print(somar(22, 6, () {
    print("inicialiando soma sem isValid...");
  }));
}

double somar(double a, double b, Function MinhaFuncao, {bool isvalid = true}) {
  MinhaFuncao();
  if (isvalid) {
    return a + b;
  } else {
    return 15 + a + b;
  }
}
