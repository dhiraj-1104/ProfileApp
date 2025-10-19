
import 'package:flutter/material.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_cubit.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_state.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/pages/detailscreen/detail_screen.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/pages/homescreen/widgets/image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      BlocBuilder<PersonCubit,PersonState>(builder: (context, state) {
        if(state is PersonLoading){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is PersonLoaded){

          return Container(
            padding: EdgeInsets.only(top: 20,right: 5,left: 5),
            child: RefreshIndicator(
              onRefresh: () async{
                await context.read<PersonCubit>().fetchPerson();
              },
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2), itemBuilder: (context, index) {
                final person = state.persons[index];
                return ImageContainer(name: person.name, imgUrl: person.imgUrl,state: person.ste,isLiked: person.isLiked,
                    onLikeChanged: (value) {
                      context.read<PersonCubit>().toggleLike(person);
                    },onPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(person: person,
                  onLikeChanged: (value) {
                    context.read<PersonCubit>().toggleLike(person);
                  },),));

                },);
              },
                itemCount: state.persons.length,),
            ),
          );
        }else if(state is PersonError){
          return Center(child: Text(state.errorMsg),);
        }else{
          return Center(child: Text("404 Page Not Found"),);
        }
      },)),
    );
  }
}

