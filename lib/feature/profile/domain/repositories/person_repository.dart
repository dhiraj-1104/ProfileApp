import '../entities/person.dart';

// Repository interface for retrieving the Profile Entity
abstract class PersonRepository{
  Future<List<Person>> getPerson();
}