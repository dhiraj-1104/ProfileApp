
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
        // Shows the circularProgress indicator when the state is loading state
        if(state is PersonLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        // shows the profile of person when is completed fetching if from api
        else if(state is PersonLoaded){
          return Container(
            padding: EdgeInsets.only(top: 20,right: 5,left: 5),
            child: RefreshIndicator(
              onRefresh: () async{
                await context.read<PersonCubit>().fetchPerson();
              },
              // GridView builder to show the profiles in grid
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2), itemBuilder: (context, index) {
                final person = state.persons[index];
                return ImageContainer(name: person.name, imgUrl: person.imgUrl,state: person.ste,isLiked: person.isLiked,
                    onLikeChanged: (value) {
                  // These updates the ui if like button is clicked
                      context.read<PersonCubit>().toggleLike(person);
                    },onPress: () {
                  // Navigates to the Details page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(person: person,
                  onLikeChanged: (value) {
                    // These updates the ui if like button is clicked in the detail screen.
                    context.read<PersonCubit>().toggleLike(person);
                  },),));
                },);
              },
                itemCount: state.persons.length,),
            ),
          );
          // Shows the Error Screen if there is error
        }else if(state is PersonError){
          return Center(child: Text(state.errorMsg),);
        }else{
          // Shows The 404 Page
          return Center(child: Text("404 Page Not Found"),);
        }
      },)),
    );
  }
}

