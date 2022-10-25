//validator for the price in the sell screen
// checks if the price is empty and if its in the correct format
class PriceValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp('^[0-9]*\$');
    if (value!.isEmpty) {
      return ("Price cannot be empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Numeric Values Only");
    }
    return null;
  }
}
