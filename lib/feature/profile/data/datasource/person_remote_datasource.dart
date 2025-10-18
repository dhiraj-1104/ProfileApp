import 'package:dio/dio.dart';
import 'package:profile_app_assignment/feature/profile/data/model/person_model.dart';
import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';

// RemoteDataSource interface
abstract class PersonRemoteDatasource{
  // Fetches the Profile detail from the api
  Future<PersonModel> fetchProfile();
}

class PersonRemoteDatasourceImpl implements PersonRemoteDatasource{
  // Dio Used for fetching the Api
  final Dio dio;
  // Url
  final String baseUrl = "https://randomuser.me/api/?results=20";

  PersonRemoteDatasourceImpl(this.dio);

  // These function fetches the api
  @override
  Future<PersonModel> fetchProfile() async{
    final response = await dio.get(baseUrl);
    return PersonModel.fromJson(response.data);

  }
}