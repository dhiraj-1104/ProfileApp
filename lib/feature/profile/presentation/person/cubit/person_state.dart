
// Abstract State class
abstract class PersonState{}

// Initial State
class PersonInitial extends PersonState{}

// Loading State
class PersonLoading extends PersonState{}

// Loaded State
class PersonLoaded extends PersonState{
  final List persons;
  PersonLoaded(this.persons);
}

// Error State
class PersonError extends PersonState{
  final String errorMsg;
  PersonError(this.errorMsg);
}