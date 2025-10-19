import 'package:profile_app_assignment/feature/profile/domain/entities/person.dart';

abstract class PersonState{}

class PersonInitial extends PersonState{}

class PersonLoading extends PersonState{}

class PersonLoaded extends PersonState{
  final List persons;
  PersonLoaded(this.persons);
}

class PersonError extends PersonState{
  final String errorMsg;
  PersonError(this.errorMsg);
}