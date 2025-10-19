import 'package:bloc/bloc.dart';
import 'package:profile_app_assignment/feature/profile/domain/usecases/get_person.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_state.dart';

import '../../../domain/entities/person.dart';

class PersonCubit extends Cubit<PersonState>{
  final GetPerson getPerson;
  PersonCubit(this.getPerson) : super(PersonInitial());

  Future<void> fetchPerson() async{
    emit(PersonLoading());
    try{
      final List persons = await getPerson();
      print(persons);
      emit(PersonLoaded(persons));
    }catch(e){
      emit(PersonError(e.toString()));
    }}
  void toggleLike(Person person) {
    if (state is PersonLoaded) {
      final currentState = state as PersonLoaded;

      final updatedPersons = currentState.persons.map((p) {
        if (p.name == person.name) {
          // Create a new Person with toggled isLiked
          return Person(
            imgUrl: p.imgUrl,
            name: p.name,
            age: p.age,
            ste: p.ste,
            country: p.country,
            isLiked: !p.isLiked, // toggle value
          );
        }
        return p;
      }).toList();

      emit(PersonLoaded(updatedPersons));
    }
  }
}

