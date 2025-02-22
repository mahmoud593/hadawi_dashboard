import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../utiles/helper/material_navigation.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/toast.dart';
import '../controller/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          DefaultTextField(
              controller: emailController,
              hintText: 'البريد الإلكتروني',
              validator: (value) {
                if (value.isEmpty) {
                  return 'من فضلك أدخل البريد الإلكتروني';
                }
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              fillColor: Colors.transparent),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .04,
          ),
          DefaultTextField(
              controller: passwordController,
              hintText: 'كلمة المرور',
              validator: (value) {
                if (value.isEmpty) {
                  return 'من فضلك أدخل كلمة المرور';
                }
              },
              isPassword: true,
              viewPassword: true,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              fillColor: Colors.transparent),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .15,
          ),
          BlocConsumer<AuthCubit,AuthState>(
              listener: (context, state) {
                if(state is UserLoginSuccessState){
                  customPushAndRemoveUntil(context, HomeScreen());
                  UserDataFromStorage.setUserIsLogin(true);
                }
                if(state is UserLoginErrorState){
                  customToast(title: state.message, color: ColorManager.error);
                }
              },
              builder: (context, state) {
                var cubit = context.read<AuthCubit>();
                return state is LoginLoading?
                const Center(child: CircularProgressIndicator(),):
                DefaultButton(
                    buttonText: 'تسجيل الدخول',
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        cubit.login(
                            email: emailController.text,
                            password: passwordController.text
                        );
                      }
                    },
                    buttonColor: ColorManager.primaryBlue
                );
              }
          ),
        ],
      ),
    );
  }
}
