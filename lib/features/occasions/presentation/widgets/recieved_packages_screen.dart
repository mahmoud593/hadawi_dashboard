import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/recieved_occastions_entity.dart';
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

    if (cubit.webImageBytes.isEmpty) {
      return Row(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            width: MediaQuery.sizeOf(context).width * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesEmptyImage,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'قم بإرفاق صورة الهدية بعد التغليف',
                    style: TextStyles.textStyle18Medium
                        .copyWith(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => cubit.pickGiftImage(),
            icon: Icon(
              Icons.upload,
              color: ColorManager.primaryBlue,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).height * 0.6,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .3,
                mainAxisExtent: 100),
            itemCount: cubit.receivedOccasions!.imageUrls.isEmpty
                ? cubit.webImageBytes.length
                : cubit.receivedOccasions?.imageUrls.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    width: MediaQuery.sizeOf(context).height * 0.6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: cubit.receivedOccasions == null
                        ? Image.memory(
                            cubit.webImageBytes[index],
                            height: MediaQuery.sizeOf(context).height * .4,
                            width: MediaQuery.sizeOf(context).height * 0.6,
                            fit: BoxFit.fill,
                          )
                        : CachedNetworkImage(
                            imageUrl: cubit.receivedOccasions!.imageUrls[index],
                            height: MediaQuery.sizeOf(context).height * .4,
                            width: MediaQuery.sizeOf(context).height * 0.6,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),),
                  ),
                  Positioned(
                    top: 5,
                    child: IconButton(
                      onPressed: () {
                        cubit.webImageBytes.removeAt(index);
                        cubit.emit(ClearImageState());
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
