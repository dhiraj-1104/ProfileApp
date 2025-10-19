import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/pages/homescreen/home_screen.dart';
import 'package:profile_app_assignment/injection_container.dart' as di;

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.personCubit..fetchPerson(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme()
        ),
        home: HomeScreen(),
      ),
    );
  }
}
