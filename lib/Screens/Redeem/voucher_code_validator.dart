//validator for the voucher code in the redeem screen
// checks if the voucher code is empty and if its in the correct format

class VoucherCodeValidator {
  static String? validate(String? value) {
    RegExp regex = RegExp(r'^.{12}$');
    if (value!.isEmpty) {
      return ("Voucher Code Cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Please Enter Valid Voucher Code (12 Character Code Only)");
    }
    return null;
  }
}
