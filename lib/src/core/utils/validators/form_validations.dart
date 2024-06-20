String? validatePassword(String? value) {
    // Password must be at least 8 characters long
    if (value == null || value.isEmpty || value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Password must contain at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    // Password must contain at least one capital letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }

    // Password must contain at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null; // Return null if validation succeeds
  }


  String? validateEmail(String? value) {
    // Null or empty check
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // Regex pattern for valid email addresses
    String pattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);

    // Check if the entered value matches the pattern
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null; // Return null if the validation succeeds
  }