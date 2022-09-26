//validator for the product name in the sell screen
// checks if the product name is empty and if its in the correct format
class ProductNameValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Product Name Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter Product Name (3 Characters Min)");
    }
    return null;
  }
}
