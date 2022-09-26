//validator for the category in the sell screen
// checks if the category is empty and if its in the correct format
class CategoryValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Category Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter A Category (3 Characters Min)");
    }
    return null;
  }
}
