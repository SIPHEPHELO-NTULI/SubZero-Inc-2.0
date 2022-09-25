class PriceValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp('r^[0-9]*');
    if (value!.isEmpty) {
      return ("Price cannot be empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Numeric Values Only");
    }
    return null;
  }
}
