import 'package:profile_app_assignment/feature/profile/data/datasource/person_remote_datasource.dart';
import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';
import 'package:profile_app_assignment/feature/profile/domain/repositories/person_repository.dart';

// Repository Implementation
class PersonRepositoryImpl implements PersonRepository{
  final PersonRemoteDatasource personRemoteDatasource;

  PersonRepositoryImpl(this.personRemoteDatasource);

  // Function takes the data from the ProfileRemoteDatasource
  @override
  Future<Person> getPerson() async{
    final model = await personRemoteDatasource.fetchProfile();
    // Return the response in the form of Entity which is required by the Ui of the App
    return model.toEntity();
  }

}
