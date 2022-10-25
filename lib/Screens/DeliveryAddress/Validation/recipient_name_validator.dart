//validator for the recipient name in the add delivery address screen
// checks if the recipient name is empty
class RecipientNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return ("Recipient Name Missing");
    }
    return null;
  }
}
