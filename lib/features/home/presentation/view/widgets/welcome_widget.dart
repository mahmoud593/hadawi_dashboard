import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

class WelcomeWidget extends StatelessWidget {
 const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('اهلا وسهلا',style: TextStyle(
              color: ColorManager.black,
            ),),

            SizedBox( width:  MediaQuery.sizeOf(context).height*0.02,),

            Image(
                height:MediaQuery.sizeOf(context).height*0.05,
                image: AssetImage('assets/images/wave.png')
            ),
          ],
        ),
        SizedBox( height:  MediaQuery.sizeOf(context).height*0.01,),
        Text('اهلا بك في لوحة التحكم',style: TextStyle(
          color: ColorManager.black,
        ),),
      ],
    );
  }
}
