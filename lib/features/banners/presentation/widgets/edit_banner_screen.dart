import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/banners/domain/banners_entity/banners_entity.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:toastification/toastification.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../widgets/dashboard_app_bar_widget.dart';
import '../controller/banners_cubit.dart';

class EditBannerScreen extends StatelessWidget {
  final BannersEntity bannersEntity;

  const EditBannerScreen({super.key, required this.bannersEntity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BannersCubit>();
    debugPrint('EditBannerScreen======> ${bannersEntity.bannerName}');
    cubit.bannerNameController.text = bannersEntity.bannerName;

    return BlocConsumer<BannersCubit, BannersState>(
      listener: (context, state) {
        if (state is EditBannerSuccess) {
          cubit.getBanners().then(
            (value) {
              toastification.show(
                context: context,
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 3),
                title: Text(
                  'تم تعديل البنر بنجاح',
                  style: TextStyles.textStyle18Medium
                      .copyWith(color: ColorManager.success),
                ),
              );
              Navigator.pop(context);
              // cubit.editBannerNameController.clear();
            },
          );
        }
        if (state is EditBannerErrorState) {
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
            appBar:
                dashboardAppBarWidget(context: context, text: 'تعديل الإعلان'),
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
                  child: Form(
                    key: cubit.bannerFormKey,
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
                        Row(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.3,
                                      width: MediaQuery.sizeOf(context).height *
                                          0.6,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: cubit.webImageBytes == null
                                          ? CachedNetworkImage(
                                              imageUrl: bannersEntity.image,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) {
                                                return const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                );
                                              },
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.4,
                                              fit: BoxFit.fill,
                                            )
                                          : Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.6,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Image.memory(
                                                cubit.webImageBytes!,
                                                fit: BoxFit.fill,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        .3,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.6,
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).height *
                                          0.02,
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
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.clearImage();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: ColorManager.black,
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          child: DefaultTextField(
                            controller: cubit.bannerNameController,
                            initialValue: bannersEntity.bannerName,
                            enable: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال اسم الإعلان';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.transparent,
                            hintText: '',
                          ),
                        ),
                        Spacer(),
                        state is EditBannerLoadingState
                            ? Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: CircularProgressIndicator())
                            : Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: SizedBox(
                                  width: SizeConfig.height * 0.2,
                                  child: DefaultButton(
                                      buttonText: 'تعديل الاعلان',
                                      onPressed: () {
                                        cubit.editBanner(
                                            bannerId: bannersEntity.id,
                                            image: bannersEntity.image);
                                      },
                                      buttonColor: ColorManager.warning),
                                ),
                              )
                      ],
                    ),
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
