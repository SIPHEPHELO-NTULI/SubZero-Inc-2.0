//validator for the complex name in the add delivery address screen
// checks if the complex name is empty
class ComplexNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("Complex Name Missing");
    }
    return null;
  }
}
