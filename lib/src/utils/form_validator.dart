class FormValidator {
  FormValidator._();
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return FormConstants.emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return FormConstants.invalidEmailError;
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return FormConstants.nameInputEmptyError;
    } else if (name.length < 3) {
      return FormConstants.nameLengthInputEmptyError;
    }
    return null;
  }

  static String? lastnameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return FormConstants.lastnameInputEmptyError;
    } else if (name.length < 3) {
      return FormConstants.lastNameLengthInputEmptyError;
    }
    return null;
  }

  static String? contactValidator(String? contact) {
    if (contact == null || contact.isEmpty) return FormConstants.emptyContactError;
    if (contact.isValidContact) return null;
    return FormConstants.invalidContactError;
  }

  static String? datevalidator(String? date) {
    if (date == null || date.isEmpty) {
      return FormConstants.dateInputEmptyError;
    }
    return null;
  }

  static String? timevalidator(String? time) {
    if (time == null || time.isEmpty) {
      return FormConstants.warrantyInputEmptyError;
    }
    return null;
  }

  static String? clainvalidator(String? time) {
    if (time == null || time.isEmpty) {
      return FormConstants.calimInputEmptyError;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return FormConstants.emptyPasswordInputError;
    } else if (password.length < 6) {
      return FormConstants.passwordgreaterthansix;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {String? firstPassword, String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return FormConstants.emptyConfirmPasswordInputError;
    } else if (firstPassword != confirmPassword) {
      return FormConstants.confirmPasswordNotMatched;
    }
    return null;
  }

  static String? feedbackSubjectValidator(String? subject) {
    if (subject == null || subject.isEmpty) {
      return FormConstants.emptysubjectError;
    } else if (subject.length < 3) {
      return FormConstants.subjectLessthanThree;
    }
    return null;
  }

  static String? feedbackDetailsValidator(String? details) {
    if (details == null || details.isEmpty) {
      return FormConstants.emptyDetailsError;
    } else if (details.length < 10) {
      return FormConstants.feedbackLessthanTen;
    }
    return null;
  }
}

extension StringExt on String {
  bool get isValidEmail => FormConstants.emailRegex.hasMatch(this);
  bool get isValidContact => FormConstants.contactRegex.hasMatch(this);
}

class FormConstants {

  FormConstants._();
  static const invalidEmailError = 'Please enter a valid email address';
  static const emptyPasswordInputError = 'Please enter your password';
  static const emptyConfirmPasswordInputError =
      'Please enter a confirm password';
  static const passwordgreaterthansix =
      'Password must be greater than 6 character';
  static const emptyEmailInputError = 'Please enter your email';
  static const nameInputEmptyError = "Please enter your first name";
  static const lastnameInputEmptyError = "Please enter your first name";
  static const dateInputEmptyError = "Purchase Date can not be empty";
  static const warrantyInputEmptyError = "Warranty Time can not be empty";
  static const calimInputEmptyError = "Claim Time can not be empty";
  static const nameLengthInputEmptyError = "First name Length can not be less than 3";
  static const lastNameLengthInputEmptyError = "Last name Length can not be less than 3";
  static const confirmPasswordNotMatched = "Confirm password do not match";
  static const invalidContactError = 'Please enter a valid contact';
  static const emptyContactError = 'Please enter your contact number';
  static const emptysubjectError = "Please enter feedback subject";
  static const subjectLessthanThree = "Subject must be greater than 3";
  static const emptyDetailsError = "Please enter feedback details";
  static const feedbackLessthanTen = "Details must be greater than 10";
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );
  static RegExp contactRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
}