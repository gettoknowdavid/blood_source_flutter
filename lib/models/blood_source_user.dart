import 'package:cloud_firestore/cloud_firestore.dart';

class BloodSourceUser {
  final String firstName;
  final String lastName;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String phone;
  final String city;
  final GeoPoint location;
  final String email;
  final String avatar;
  final String bloodGroup;

  BloodSourceUser({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.phone,
    required this.city,
    required this.location,
    required this.email,
    required this.avatar,
    required this.bloodGroup,
  });

  BloodSourceUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : firstName = snapshot.data()?['firstName'] as String,
        lastName = snapshot.data()?['lastName'] as String,
        gender = snapshot.data()?["gender"] as String,
        age = snapshot.data()?["age"] as int,
        height = snapshot.data()?["height"] as double,
        weight = snapshot.data()?["weight"] as double,
        city = snapshot.data()?['city'] as String,
        location = snapshot.data()?['location'] as GeoPoint,
        phone = snapshot.data()?['phone'] as String,
        email = snapshot.data()?['email'] as String,
        avatar = snapshot.data()?['avatar'] as String,
        bloodGroup = snapshot.data()?["bloodGroup"];

  Map<String, dynamic> toFirestore() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "age": age,
      "height": height,
      "weight": weight,
      "city": city,
      "location": GeoPoint(location.latitude, location.longitude),
      "phone": phone,
      "email": email,
      "avatar": avatar,
      "bloodGroup": bloodGroup,
    };
  }
}

enum Gender { male, female }

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      default:
        return 'None';
    }
  }
}
