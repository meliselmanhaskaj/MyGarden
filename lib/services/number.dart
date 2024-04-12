int extractNumberFromString(String wateringFrequency) {
  RegExp regExp = RegExp(r'\b(\d+)\b');
  Match? match = regExp.firstMatch(wateringFrequency);
  int numero;
  if (match != null) {
    String numberAsString = match.group(0)!;
    numero = int.parse(numberAsString);
  } else {
    numero = 0;
  }
  return numero;
}
