import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';

// Profile Model
class PersonModel {
  // Url of the person image
  final String imgUrl;
  // Name of the Person
  final String firstName;
  // Age of the Person
  final int age;
  // State of the Person
  final String state;
  // Country of the Person
  final String country;

  PersonModel({
    required this.imgUrl,
    required this.firstName,
    required this.age,
    required this.state,
    required this.country,
  });

  // Function to convert json into model
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      imgUrl: json['picture']['large'] ?? '',
      firstName: json['name']['first'] ?? '',
      age: json['dob']['age'] ?? 0,
      state: json['location']['state'] ?? '',
      country: json['location']['country'] ?? '',
    );
  }

  // Function to Convert model into entity
  Person toEntity() {
    return Person(imgUrl: imgUrl, name: firstName, age: age, ste: state, country: country

    );
  }
}
