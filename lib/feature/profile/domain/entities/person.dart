// Profile Entity
class Person {
  // Url of the person image
  final String imgUrl;
  // Name of the Person
  final String name;
  // Age of the Person
  final int age;
  //State
  final String ste;
  // Country
  final String country;
  //Like
  bool isLiked;

  Person({required this.imgUrl,required this.name,required this.age,required this.ste,required this.country,this.isLiked = false});
}