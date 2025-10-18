import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';
import 'package:profile_app_assignment/feature/profile/domain/repositories/person_repository.dart';

// UseCase for retrieving use Profile
class GetPerson{
  final PersonRepository profileRepository;

  GetPerson(this.profileRepository);

  Future<Person> call() async{
    return await profileRepository.getPerson();
  }
}