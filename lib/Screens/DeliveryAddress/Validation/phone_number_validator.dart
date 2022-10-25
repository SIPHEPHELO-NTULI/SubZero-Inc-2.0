//validator for the phone number in the add delivery address screen
// checks if the phone number is empty
class PhoneNumberValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp('^[0-9]*\$');

    if (value!.isEmpty) {
      return ("Phone Number Missing");
    }
    if (!regex.hasMatch(value)) {
      return ("Phone number must contain numeric values only");
    }
    if (value.length != 10) {
      return ("Phone number must be 10 digits");
    }
    return null;
  }
}
