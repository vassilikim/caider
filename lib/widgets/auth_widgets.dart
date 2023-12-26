extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+[\.\-\_]*[a-zA-Z0-9]*)+[@][a-z]{2,}[\.][a-z]{2,3}$')
        .hasMatch(this);
  }
}

extension PhoneNumberValidator on String {
  bool isValidPhoneNumber() {
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}
