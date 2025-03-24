import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/notification_details_view_body.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_states.dart';
import 'package:hadawi_dathboard/features/settings/presentation/controller/settings_cubit.dart';
import 'package:hadawi_dathboard/features/settings/presentation/controller/settings_states.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit,SettingsStates>(
      listener: (context, state) {
        if(state is ChangeAdminCredentialsSuccessState){
          toastificationWidget(context: context, title: 'تم الحفظ', body: 'تم تغير البريد الالكتروني و كلمه المرور بنجاح', type: ToastificationType.success);
        }
      },
      builder: (context, state) {
        var cubit = context.read<SettingCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is UpdatePrivacyLoadingState || state is ChangeAdminCredentialsLoadingState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),

                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                ),

                height:  SizeConfig.height*0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  color: ColorManager.white,

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox( height: SizeConfig.height*0.02,),

                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(AssetsManager.logoWithoutBackground),
                        height: SizeConfig.height*0.15,
                      ),
                    ),

                    SizedBox( height: SizeConfig.height*0.04,),

                    buildTextField('البريد الالكتروني'),

                    SizedBox( height: SizeConfig.height*0.01,),

                    DefaultTextField(
                        controller: cubit.emailController,
                        hintText: 'ادخل البريد الالكتروني',
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'ادخل البريد الالكتروني';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray
                    ),

                    SizedBox( height: SizeConfig.height*0.04,),

                    buildTextField('كلمه المرور'),

                    SizedBox( height: SizeConfig.height*0.01,),

                    DefaultTextField(
                        controller: cubit.passwordController,
                        hintText: 'ادخل كلمه المرور',
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'ادخل كلمه المرور';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        withSuffix: true,
                        viewPassword: true,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        fillColor: ColorManager.gray
                    ),

                    SizedBox( height: SizeConfig.height*0.06,),

                    DefaultButton(
                        buttonText: 'حفظ',
                        onPressed: (){
                          cubit.changeAdminCredentials(
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text
                          );
                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
