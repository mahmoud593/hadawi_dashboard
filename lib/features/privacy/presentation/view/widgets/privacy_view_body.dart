import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_cubit.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_states.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../styles/colors/color_manager.dart';

class PrivacyViewBody extends StatefulWidget {
  const PrivacyViewBody({super.key});

  @override
  State<PrivacyViewBody> createState() => _PrivacyViewBodyState();
}

class _PrivacyViewBodyState extends State<PrivacyViewBody> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text= context.read<PrivacyCubit>().privacy;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyCubit,PrivacyState>(
        builder: (context, state) {
          var cubit = context.read<PrivacyCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is UpdatePrivacyLoadingState,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),

              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
    
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                color: ColorManager.white,
              ),
    
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.height *.03 , ),
                  Expanded(
                    child: DefaultTextField(
                        maxLines: 25,
                        controller: controller,
                        hintText: 'سياسه الاستخدام و الخصوصيه',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        fillColor: Colors.white
                    ),
                  ),

                  SizedBox(height: SizeConfig.height *.03 , ),
    
                  Container(
                    width: SizeConfig.width*.5  ,
                    child: DefaultButton(
                        buttonText: 'تحديث',
                        onPressed: () {
                          cubit.updatePrivacy(text: controller.text );
                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ),
                  SizedBox(height: SizeConfig.height *.03 , ),


                ],
    
              ),
    
            ),
          );
        },
        listener: (context, state) {
          if(state is UpdatePrivacySuccessState){
            customToast(title: 'تم تحديث سياسه الاستخدام و الخصوصيه', color: ColorManager.primaryBlue);
            customPushAndRemoveUntil(context, HomeScreen());
          }
          if(state is UpdatePrivacyErrorState){
            customToast(title: state.error, color: ColorManager.red);
          }
        }
    );
  }
}
