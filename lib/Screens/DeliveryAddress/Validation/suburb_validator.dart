//validator for the suburb in the add delivery address screen
// checks if the suburb is empty
class SuburbValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("Suburb Missing");
    }
    return null;
  }
}
