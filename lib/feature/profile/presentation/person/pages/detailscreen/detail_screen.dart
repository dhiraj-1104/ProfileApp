
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_cubit.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_state.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/pages/detailscreen/widgets/top_curve_clipper.dart';

import '../../../../domain/entities/person.dart';

class DetailScreen extends StatefulWidget {
  final Person person;
  final ValueChanged<bool>? onLikeChanged;
  const DetailScreen({super.key, required this.person, this.onLikeChanged});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin{
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();

    isLiked = widget.person.isLiked;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onIconTap() {
    setState(() {
      isLiked = !isLiked;
      print(isLiked);
    });

    // Play the pop animation
    _controller.forward().then((_) => _controller.reverse());
    print(isLiked);
    widget.onLikeChanged?.call(isLiked);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.person.name,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.person.imgUrl,),fit: BoxFit.cover)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 15,left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: () => Navigator.pop(context),),
                  Icon(Icons.more_vert,color: Colors.white,)
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CustomNotch(
                  ),
                child: Container(
                  height: MediaQuery.sizeOf(context).height *0.20,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("${widget.person.name}, ${widget.person.age}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Location", style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                                Text("${widget.person.ste}, ${widget.person.country}",style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            BlocBuilder<PersonCubit,PersonState>(builder: (context, state) {
                              if(state is PersonLoaded){
                                final updatedPerson = state.persons.firstWhere((element) => element.name == widget.person.name,);
                                return GestureDetector(
                                    onTap: _onIconTap,
                                    child: ScaleTransition(
                                        scale: _scaleAnimation,
                                        child: Icon(updatedPerson.isLiked ? Icons.favorite : Icons.favorite_border,weight: 10,color: updatedPerson.isLiked ? Colors.red : Colors.grey,)));
                              }
                              return Icon(Icons.favorite_border, color: Colors.grey);
                            },)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * 0.19,
              right: MediaQuery.sizeOf(context).width * 0.40,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.01,
                width: MediaQuery.sizeOf(context).width * 0.20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
