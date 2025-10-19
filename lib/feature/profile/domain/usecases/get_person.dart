import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';
import 'package:profile_app_assignment/feature/profile/domain/repositories/person_repository.dart';

// UseCase for retrieving Person
class GetPerson{
  final PersonRepository personRepository;

  GetPerson(this.personRepository);

  Future<List<Person>> call() async{
    return await personRepository.getPerson();
  }
}