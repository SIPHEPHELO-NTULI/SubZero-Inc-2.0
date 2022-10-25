//validator for the street address in the add delivery address screen
// checks if the street address is empty
class StreetAddressValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("Street Address Missing");
    }
    return null;
  }
}
