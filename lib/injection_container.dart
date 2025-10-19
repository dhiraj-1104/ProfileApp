import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:profile_app_assignment/feature/profile/data/datasource/person_remote_datasource.dart';
import 'package:profile_app_assignment/feature/profile/data/repositoriesImpl/person_repository_impl.dart';
import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';
import 'package:profile_app_assignment/feature/profile/domain/repositories/person_repository.dart';
import 'package:profile_app_assignment/feature/profile/domain/usecases/get_person.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_cubit.dart';

final dio = Dio();
final remoteDs = PersonRemoteDatasourceImpl(dio);
final repository = PersonRepositoryImpl(remoteDs);
final getPerson = GetPerson(repository);
final personCubit = PersonCubit(getPerson);