//validator for the review in the product details screen
// checks if the review is empty and if its in the correct format

class ReviewFieldValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Review Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("(3 Characters Min)");
    }
    return null;
  }
}
