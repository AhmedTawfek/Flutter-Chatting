class ValidationUtils {
  bool isEmailCorrect(String email) {
    if (email.isEmpty) {
      return false;
    }

    const String emailRegex = r"^((([\w-]+\.)+[\w-]+|([a-zA-Z]{1}|[\w-]{2,}))@"
        r"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
        r"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
        r"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
        r"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
        r"([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4}))$";

    final RegExp pattern = RegExp(emailRegex);
    return pattern.hasMatch(email);
  }

  bool isPasswordCorrect({required String password}) {
    if (password.isNotEmpty && password.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}
