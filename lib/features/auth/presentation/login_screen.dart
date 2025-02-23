import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/auth/data/repo_imp/user_repo_imp.dart';
import 'package:hadawi_dathboard/features/auth/presentation/controller/auth_cubit.dart';
import 'package:hadawi_dathboard/features/auth/presentation/widgets/login_body_view.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: BlocProvider(
          create: (context) => AuthCubit(UserRepoImp()),
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: .1,
                  image: AssetImage(AssetsManager.logoWithoutBackground,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: LoginBodyView()),
        ));
  }
}
