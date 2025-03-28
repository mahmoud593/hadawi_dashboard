import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../styles/size_config/app_size_config.dart';
import '../../../../styles/text_styles/text_styles.dart';
import '../../../../widgets/dashboard_app_bar_widget.dart';
import '../../../../widgets/default_button.dart';
import '../../../../widgets/default_text_field.dart';
import '../controller/occasions_cubit.dart';

class ReceivedPackageDetails extends StatelessWidget {
 final String occasionId;
    const ReceivedPackageDetails({super.key , required this.occasionId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionsCubit, OccasionsState>(
      builder: (context, state) {
        final cubit = context.read<OccasionsCubit>();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar:
            dashboardAppBarWidget(context: context, text: 'تفاصيل المناسبة المنجزة'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * .7,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: cubit.receivedOccasionsFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'صورة الباكيدج',
                          style: TextStyles.textStyle18Medium
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
                                        imageUrl: cubit.receivedOccasions?.imageUrls??'',
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
                                          cubit.pickGiftImage();
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
                        Text(
                          'السعر النهائي',
                          style: TextStyles.textStyle18Medium
                              .copyWith(color: ColorManager.black),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          child: DefaultTextField(
                            controller: cubit.finalPriceController,
                            initialValue:cubit.receivedOccasions?.finalPrice.toString(),
                            enable: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال سعر النهائي';
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
                        state is UpdateOccasionsLoadingState
                            ? Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: CircularProgressIndicator())
                            :
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: SizedBox(
                            width: SizeConfig.height * 0.2,
                            child: DefaultButton(
                                buttonText: 'تعديل',
                                onPressed: () {
                                 cubit. editReceivedOccasion(
                                   occasionId:  cubit.receivedOccasions?.id??'',
                                   finalPrice: double.parse(cubit.finalPriceController.text) ,
                                   // image: cubit.webImageBytes
                                 );
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
      listener: (context, state) {
        if(state is UpdateOccasionSuccess){
          context.read<OccasionsCubit>().getReceivedOccasions(occasionId: occasionId).then(
                (value) {
              toastification.show(
                context: context,
                type: ToastificationType.success,
                autoCloseDuration: const Duration(seconds: 3),
                title: Text(
                  'تم تعديل التفاصيل بنجاح',
                  style: TextStyles.textStyle18Medium
                      .copyWith(color: ColorManager.success),
                ),
              );
              Navigator.pop(context);
              // cubit.editBannerNameController.clear();
            },
          );
        }

    },);
  }
}
