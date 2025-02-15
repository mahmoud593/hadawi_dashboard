import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/banners/presentation/controller/banners_cubit.dart';
import 'package:hadawi_dathboard/generated/assets.dart';
import 'package:toastification/toastification.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../styles/size_config/app_size_config.dart';
import '../../../../styles/text_styles/text_styles.dart';
import '../../../../widgets/dashboard_app_bar_widget.dart';
import '../../../../widgets/default_button.dart';

class AddBannersScreen extends StatelessWidget {
  const AddBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BannersCubit>();

    return BlocConsumer<BannersCubit, BannersState>(
      listener: (context, state) {
        if (state is AddBannersSuccessState) {
          cubit.webImageBytes = null;
          cubit.getBanners().then((value) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 3),
              title: Text(
                'تم اضافة البنر بنجاح',
                style: TextStyles.textStyle18Medium
                    .copyWith(color: ColorManager.success),
              ),
            );
            Navigator.pop(context);
          },);
        }
        if (state is AddBannersErrorState) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 3),
            title: Text(
              state.error,
              style: TextStyles.textStyle18Medium
                  .copyWith(color: ColorManager.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: dashboardAppBarWidget('إضافة إعلان'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * .6,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'صورة الإعلان',
                        style: TextStyles.textStyle18Bold
                            .copyWith(color: ColorManager.black),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      cubit.webImageBytes == null
                          ? Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                  width:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Assets.imagesEmptyImage,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.3,
                                        width:
                                            MediaQuery.sizeOf(context).height *
                                                0.3,
                                      ),
                                      Text(
                                        ' قم بإرفاق صورة الإعلان',
                                        style: TextStyles.textStyle18Medium
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).height * 0.02,
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.pickBannerImage();
                                    },
                                    icon: Icon(
                                      Icons.upload,
                                      color: ColorManager.primaryBlue,
                                    ))
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                  width:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Image.memory(
                                    cubit.webImageBytes!,
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.sizeOf(context).height * .3,
                                    width:
                                        MediaQuery.sizeOf(context).height * 0.6,
                                  ),
                                )
                              ],
                            ),
                      Spacer(),
                      state is AddBannersLoadingState
                          ? CircularProgressIndicator(): Align(
                           alignment:  AlignmentDirectional.bottomEnd,
                            child: SizedBox(
                              width: SizeConfig.height * 0.2,
                              child: DefaultButton(
                                  buttonText: 'إضافة الاعلان',
                                  onPressed: () {
                                    if(cubit.webImageBytes!=null){
                                      cubit.addBanner();
                                    }else{
                                      toastification.show(
                                        context: context,
                                        type: ToastificationType.error,
                                        autoCloseDuration: const Duration(seconds: 5),
                                        title: Text(
                                          'قم باختيار صورة الإعلان',
                                          style: TextStyles.textStyle18Medium
                                              .copyWith(color: ColorManager.error),
                                        ),
                                      );
                                    }
                                  },
                                  buttonColor: ColorManager.primaryBlue),
                            ),
                          )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
