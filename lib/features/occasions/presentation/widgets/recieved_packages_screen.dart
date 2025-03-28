import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/generated/assets.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:toastification/toastification.dart';
import '../../../../styles/colors/color_manager.dart';
import '../../../../styles/size_config/app_size_config.dart';
import '../../../../widgets/default_button.dart';

class ReceivedPackagesScreen extends StatelessWidget {
  final String occasionId;

  const ReceivedPackagesScreen({
    super.key,
    required this.occasionId,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Right-to-left for Arabic
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: dashboardAppBarWidget(
          context: context,
          text: 'المناسبات المنجزة',
        ),
        body: BlocConsumer<OccasionsCubit, OccasionsState>(
          listener: (context, state) {
            if (state is AddReceivedOccasionsSuccessState) {
              toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  autoCloseDuration: const Duration(seconds: 5),
                  title: Text(
                    'تم',
                    style: TextStyles.textStyle18Medium
                        .copyWith(color: ColorManager.primaryBlue),
                  ),
                  description: Text('تم اضافة تفاصيل المناسبة بنجاح',
                      style: TextStyles.textStyle18Medium));
              Navigator.pop(context);
            }
            if (state is AddReceivedOccasionsErrorState) {
              toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  autoCloseDuration: const Duration(seconds: 5),
                  title: Text(
                    'فشل',
                    style: TextStyles.textStyle18Medium
                        .copyWith(color: ColorManager.primaryBlue),
                  ),
                  description:
                      Text(state.error, style: TextStyles.textStyle18Medium));
            }
            if (state is PickGiftImageErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('فشل اختيار الصور')),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<OccasionsCubit>();
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200]!,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "صورة الهدية بعد التغليف",
                        style: TextStyles.textStyle18Bold,
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      _buildImageSection(context, cubit, state),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      Text(
                        "السعر النهائي للهدية",
                        style: TextStyles.textStyle18Bold,
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.35,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        child: DefaultTextField(
                            controller: cubit.finalPriceController,
                            hintText: "",
                            enable: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال السعر النهائي للهدية';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.transparent),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      state is AddReceivedOccasionsLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: SizedBox(
                                width: SizeConfig.height * 0.2,
                                child: DefaultButton(
                                    buttonText: 'حفظ',
                                    onPressed: () {
                                      cubit.addReceivedOccasions(
                                          occasionId: occasionId);
                                    },
                                    buttonColor: ColorManager.primaryBlue),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageSection(
      BuildContext context, OccasionsCubit cubit, OccasionsState state) {
    if (state is PickGiftImageLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }





    return Column(
      children: [
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
                    ' قم بإرفاق صورة الهدية بعد التغليف',
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
                  cubit.pickGiftImage();
                },
                icon: Icon(
                  Icons.upload,
                  color: ColorManager.primaryBlue,
                ))
          ],
        )
            : Row(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context)
                          .height *
                          0.3,
                      width: MediaQuery.sizeOf(context)
                          .height *
                          0.6,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey),
                        borderRadius:
                        BorderRadius.circular(5.0),
                      ),
                      child: Image.memory(
                        cubit.webImageBytes!,
                        fit: BoxFit.fill,
                        height: MediaQuery.sizeOf(context)
                            .height *
                            .3,
                        width: MediaQuery.sizeOf(context)
                            .height *
                            0.6,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context)
                          .height *
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
      ],
    );
  }
}
