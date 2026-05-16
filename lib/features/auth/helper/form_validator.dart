class FormValidator {
  static String? validateName(String? username) {
    if (username == null || username.isEmpty) {
      return "You must enter your Username";
    } else if (!RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(username)) {
      return "You must enter vaild Username";
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "You must enter your Username";
    } else if (!RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(username)) {
      return "You must enter vaild Username";
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "You must enter your phone number";
    } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(phone)) {
      return "You must enter vaild phone number";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "You must enter your email";
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return "You must enter vaild email";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "You must enter your password";
    } else if (password.length < 8) {
      return "You must enter at least 8 characters";
    }

    final missingRequirements = <String>[];

    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   missingRequirements.add("one lowercase letter");
    // }
    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   missingRequirements.add("one uppercase letter");
    // }
    // if (!RegExp(r'\d').hasMatch(password)) {
    //   missingRequirements.add("one number");
    // }
    // if (!RegExp(r'[@$!%#*?&]').hasMatch(password)) {
    //   missingRequirements.add("one special character");
    // }

    if (missingRequirements.isNotEmpty) {
      return "Password must contain at least ${missingRequirements.join(', ')}.";
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "You must confirm your password";
    } else if (password != confirmPassword) {
      return "Passwords do not match!";
    } else {
      return null;
    }
  }
}
