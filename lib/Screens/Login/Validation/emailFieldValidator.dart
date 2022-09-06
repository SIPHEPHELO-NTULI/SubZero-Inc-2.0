class EmailFieldValidator {
  static String? validate(String? value) {
    //static becuase we won't have to create an instance
    if (value!.isEmpty) {
      return "Please Enter Your Email";
    }
    //reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }
}
