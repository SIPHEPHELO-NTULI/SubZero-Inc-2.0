class SurnameFieldValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{3,}$');
    if (value!.isEmpty) {
      return ("Surname Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter Valid Surname (3 Characters Min)");
    }
    return null;
  }
}
