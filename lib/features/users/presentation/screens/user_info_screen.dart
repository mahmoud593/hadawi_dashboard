import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/user_info_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key,required this.userEntities});

  final UserEntities userEntities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: UserInfoViewBody(userEntities:  userEntities,),
    );
  }
}
