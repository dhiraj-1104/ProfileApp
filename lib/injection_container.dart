import 'package:dio/dio.dart';
import 'package:profile_app_assignment/feature/profile/data/datasource/person_remote_datasource.dart';
import 'package:profile_app_assignment/feature/profile/data/repositoriesImpl/person_repository_impl.dart';
import 'package:profile_app_assignment/feature/profile/domain/usecases/get_person.dart';

final dio = Dio();
final remoteDs = PersonRemoteDatasourceImpl(dio);
final repository = PersonRepositoryImpl(remoteDs);
final getPerson = GetPerson(repository);
