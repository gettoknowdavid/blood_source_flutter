enum Disease {
  cancer,
  cardiacDisease,
  severeLungDisease,
  hepatitisB,
  hepatitisC,
  std,
  none
}

class DiseaseExType {
  DiseaseExType({required this.name, required this.value});

  final String name;
  final bool value;
}

extension DiseaseTypeEx on Disease {
  String get value {
    switch (this) {
      case Disease.cancer:
        return 'Cancer';
      case Disease.cardiacDisease:
        return 'Cardiac Disease';
      case Disease.severeLungDisease:
        return 'Severe Lung Disease';
      case Disease.hepatitisB:
        return 'Hepatitis B';
      case Disease.hepatitisC:
        return 'Hepatitis C';
      case Disease.std:
        return 'HIV, AIDS or any Sexually Transmitted Disease (STD)';
      case Disease.none:
        return 'None';
      default:
        return 'None';
    }
  }
}
