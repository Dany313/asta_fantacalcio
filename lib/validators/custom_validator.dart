abstract class Validator {
  String? validate(String? value);
}

class CompositeValidator implements Validator {
  final List<Validator> validators;

  CompositeValidator(this.validators);

  @override
  String? validate(String? value) {
    for (var validator in validators) {
      final result = validator.validate(value);
      if (result != null) return result;
    }
    return null;
  }
}



