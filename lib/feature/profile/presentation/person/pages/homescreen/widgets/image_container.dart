import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_cubit.dart';
import 'package:profile_app_assignment/feature/profile/presentation/person/cubit/person_state.dart';

class ImageContainer extends StatefulWidget {
  final String name;
  final String state;
  final String imgUrl;
  final bool isLiked;
  final VoidCallback onPress;
  final ValueChanged<bool>? onLikeChanged;
  const ImageContainer({super.key, required this.name, required this.state, required this.imgUrl, required this.onPress, required this.isLiked, this.onLikeChanged});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    isLiked = widget.isLiked;

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
    });

    // Play the pop animation
    _controller.forward().then((_) => _controller.reverse());
    widget.onLikeChanged?.call(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Hero(
        tag: widget.name,
        child: Container(
         margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.imgUrl),fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: BlocBuilder<PersonCubit,PersonState>(builder: (context, state) {
                        if(state is PersonLoaded){
                          final updatedPerson = state.persons.firstWhere((element) => element.name == widget.name,);
                          return GestureDetector(
                              onTap: _onIconTap,
                              child: ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Icon(
                                    updatedPerson.isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: updatedPerson.isLiked ? Colors.red : Colors.white,
                                  )));
                        }
                        return Icon(Icons.favorite_border,color: Colors.white,);
                      },)
                    ),

                  ],
                ),
                Text(widget.state,
                style: TextStyle(
                  fontSize: 10,
                   color: Colors.white,
                  fontWeight: FontWeight.w900
                ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,)
              ],
            ),
          ),

        ),
      ),
    );
  }
}
