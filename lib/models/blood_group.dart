enum BloodGroup {
  none,
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  oPositive,
  oNegative,
  abPositive,
  abNegative,
}

class BloodGroupExType {
  BloodGroupExType({required this.name, required this.desc});

  final String name;
  final String desc;
}

extension BloodGroupEx on BloodGroup {
  BloodGroupExType get value {
    switch (this) {
      case BloodGroup.aPositive:
        return BloodGroupExType(name: 'A+', desc: 'A Positive (A+)');
      case BloodGroup.aNegative:
        return BloodGroupExType(name: 'A-', desc: 'A Negative (A-)');
      case BloodGroup.bPositive:
        return BloodGroupExType(name: 'B+', desc: 'B Positive (B+)');
      case BloodGroup.bNegative:
        return BloodGroupExType(name: 'B-', desc: 'B Negative (B-)');
      case BloodGroup.oPositive:
        return BloodGroupExType(name: 'O+', desc: 'O Positive (O+)');
      case BloodGroup.oNegative:
        return BloodGroupExType(name: 'O-', desc: 'O Negative (O-)');
      case BloodGroup.abPositive:
        return BloodGroupExType(name: 'AB+', desc: 'AB Positive (AB+)');
      case BloodGroup.abNegative:
        return BloodGroupExType(name: 'AB-', desc: 'AB Negative (AB-)');
      default:
        return BloodGroupExType(name: '', desc: '');
    }
  }
}

const $BloodGroupTypeEnum = {
  BloodGroup.none: 'none',
  BloodGroup.aPositive: 'A Positive (A+)',
  BloodGroup.aNegative: 'A Negative (A-)',
  BloodGroup.bPositive: 'B Positive (B+)',
  BloodGroup.bNegative: 'B Negative (B-)',
  BloodGroup.oPositive: 'O Positive (O+)',
  BloodGroup.oNegative: 'O Negative (O-)',
  BloodGroup.abPositive: 'AB Positive (AB+)',
  BloodGroup.abNegative: 'AB Negative (AB-)',
};


