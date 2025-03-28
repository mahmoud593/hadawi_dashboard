import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import '../controller/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    // context.read<AuthCubit>().loadSavedCredentials();
    if(UserDataFromStorage.isReminder==true){
      context.read<AuthCubit>().emailController.text = UserDataFromStorage.emailFromStorage;
      context.read<AuthCubit>().passwordController.text = UserDataFromStorage.password;
      context.read<AuthCubit>().rememberMe = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          context.read<AuthCubit>().saveCredentials(
                context.read<AuthCubit>().emailController.text,
                context.read<AuthCubit>().passwordController.text,
              );
          customPushAndRemoveUntil(context, const HomeScreen());
          UserDataFromStorage.setUserIsLogin(true);
        }
        if (state is UserLoginErrorState) {
          customToast(title: state.message, color: ColorManager.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Form(
          key: formKey,
          child: Column(
            children: [
              DefaultTextField(
                controller: cubit.emailController,
                initialValue: cubit.rememberMe==false
                    ? ''
                    : UserDataFromStorage.emailFromStorage,
                hintText: 'البريد الإلكتروني',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'من فضلك أدخل البريد الإلكتروني';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'البريد الإلكتروني غير صالح';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                fillColor: Colors.transparent,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .04),
              DefaultTextField(
                controller: cubit.passwordController,
                initialValue: cubit.rememberMe==false
                    ? ''
                    : UserDataFromStorage.password,
                hintText: 'كلمة المرور',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'من فضلك أدخل كلمة المرور';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
                isPassword: true,
                viewPassword: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                fillColor: Colors.transparent,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .02),
              // "Remember Me" Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'تذكرني',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 14.0,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Checkbox(
                    value: cubit.rememberMe,
                    onChanged: (value) {
                      setState(() {
                        cubit.rememberMe = value ?? false;
                        print('Value is $value');
                        if(value==true){
                          UserDataFromStorage.setIsReminder(true);
                        }else{
                          UserDataFromStorage.setIsReminder(false);
                        }
                        if (value == true) {
                          UserDataFromStorage.setEmail(cubit.emailController.text);
                          UserDataFromStorage.setPassword(cubit.passwordController.text);
                        }
                      });
                    },
                    activeColor: ColorManager.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .08),
              state is LoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DefaultButton(
                      buttonText: 'تسجيل الدخول',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.loginWithEmailPass(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                          );
                        }
                      },
                      buttonColor: ColorManager.primaryBlue,
                    ),
            ],
          ),
        );
      },
    );
  }
}
