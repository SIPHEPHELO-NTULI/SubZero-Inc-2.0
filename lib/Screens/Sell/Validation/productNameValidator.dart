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
