//validator for the province in the add delivery address screen
// checks if the province is empty
class ProvinceValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("Province Missing");
    }
    return null;
  }
}
