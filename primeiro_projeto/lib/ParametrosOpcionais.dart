void main() {
  print(somar(10, 4,
      isvalid: true)); // o parametro isValid é opcional, nao precisa passar
}

double somar(double a, double b, {bool isvalid = true}) {
  if (isvalid) {
    return a + b;
  } else {
    return 15 + a + b;
  }
}
