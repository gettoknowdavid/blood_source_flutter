enum Gender { male, female, none }

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.none:
        return 'None';
      default:
        return 'None';
    }
  }
}

const $GenderTypeEnum = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.none: 'none',
};
