class PasswordFieldValidator {
  static String? validate(String? value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return "Password Required";
    }

    if (!regex.hasMatch(value)) {
      return "Please Enter Valid Password (6 Characters Min)";
    }
    return null;
  }
}
