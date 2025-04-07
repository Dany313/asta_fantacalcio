

import 'custom_validator.dart';

class ValidatorString {
  // Proprietà statiche che restituiscono i validatori di base
  static Validator get isUppercase => _UppercaseValidator();
  static Validator get isNotEmpty => _NotEmptyStringValidator();
  static Validator get hasNoSpaces => _NoSpacesValidator();
}


class _UppercaseValidator implements Validator {
  @override
  String? validate(String? value) {
    if (value == null || value != value.toUpperCase()) {
      return 'Il testo deve essere in maiuscolo';
    }
    return null;
  }
}

class _NoSpacesValidator implements Validator {
  @override
  String? validate(String? value) {
    if (value == null || value.contains(' ')) {
      return 'Il testo non deve contenere spazi';
    }
    return null;
  }
}

class _NotEmptyStringValidator implements Validator {
  @override
  String? validate(String? value) {
    if (value != null && value.isEmpty) {
      return 'Il testo non deve essere vuoto';
    }
    return null;
  }
}

