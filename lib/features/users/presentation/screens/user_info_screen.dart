import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/user_info_view_body.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: UserInfoViewBody(),
    );
  }
}
