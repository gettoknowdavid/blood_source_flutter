enum BloodGroup {
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
        return BloodGroupExType(name: 'A+', desc: 'A Rhd Positive (A+)');
      case BloodGroup.aNegative:
        return BloodGroupExType(name: 'A-', desc: 'A Rhd Negative (A-)');
      case BloodGroup.bPositive:
        return BloodGroupExType(name: 'B+', desc: 'B Rhd Positive (B+)');
      case BloodGroup.bNegative:
        return BloodGroupExType(name: 'B-', desc: 'B Rhd Negative (B-)');
      case BloodGroup.oPositive:
        return BloodGroupExType(name: 'O+', desc: 'O Rhd Positive (O+)');
      case BloodGroup.oNegative:
        return BloodGroupExType(name: 'O-', desc: 'O Rhd Negative (O-)');
      case BloodGroup.abPositive:
        return BloodGroupExType(name: 'AB+', desc: 'AB Rhd Positive (AB+)');
      case BloodGroup.abNegative:
        return BloodGroupExType(name: 'AB-', desc: 'AB Rhd Negative (AB-)');
      default:
        return BloodGroupExType(name: '', desc: '');
    }
  }
}
