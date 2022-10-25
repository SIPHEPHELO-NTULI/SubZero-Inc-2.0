//validator for the city in the add delivery address screen
// checks if the city is empty
class CityValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("City Missing");
    }
    return null;
  }
}
