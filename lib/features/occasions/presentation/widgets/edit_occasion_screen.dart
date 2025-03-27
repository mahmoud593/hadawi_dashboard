import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/occastion_entity.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/edit_button.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../../styles/text_styles/text_styles.dart';
import '../../../../widgets/default_text_field.dart';

class EditOccasionScreen extends StatelessWidget {
  final OccasionEntity occasionEntity;

  const EditOccasionScreen({super.key, required this.occasionEntity});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OccasionsCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: dashboardAppBarWidget(context: context, text: 'تعديل المناسبة'),
        body: BlocConsumer<OccasionsCubit, OccasionsState>(
          listener: (context, state) {
            if (state is UpdateOccasionSuccess) {
              cubit.getOccasions().then(
                    (value) {
                  Navigator.pop(context);
                },
              );
              toastification.show(
                context: context,
                type: ToastificationType.success,
                autoCloseDuration:  const Duration(seconds: 5),
                title: Text(
                  'تم  تعديل المناسبة بنجاح',
                  style: TextStyles.textStyle18Medium
                      .copyWith(color: ColorManager.primaryBlue),
                ),
              );

            }
            if (state is UpdateOccasionsErrorState) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                autoCloseDuration:  const Duration(seconds: 5),
                title: Text(
                  'حدث خطأ في التعديل',
                  style: TextStyles.textStyle18Medium
                      .copyWith(color: ColorManager.primaryBlue),
                ),
                description: Text(
                  state.error,
                    style: TextStyles.textStyle18Medium

                )
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// occasion name
                      Text(
                        "اسم المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.occasionNameController,
                        hintText: '',
                        initialValue: occasionEntity.occasionName,
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// occasion date
                      Text(
                        "تاريخ المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.occasionDateController,
                        initialValue: occasionEntity.occasionDate,
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// occasion date
                      Text(
                        "نوع المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.occasionTypeController,
                        initialValue: occasionEntity.occasionType,
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// person name
                      Text(
                        "اسم صاحب المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.personNameController,
                        initialValue: occasionEntity.personName,
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// person email
                      Text(
                        "حساب صاحب المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.personEmailController,
                        hintText: '',
                        initialValue: occasionEntity.personEmail,
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// person phone
                      Text(
                        "رقم جوال صاحب المناسبة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.personPhoneController,
                        initialValue: occasionEntity.personPhone,
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// gift type
                      Text(
                        "نوع الهدية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.giftTypeController,
                        initialValue: occasionEntity.giftName.isEmpty
                            ? '${occasionEntity.giftPrice} ريال'
                            : occasionEntity.giftName,
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// gift image
                      Text(
                        "صورة الهدية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.gray.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: occasionEntity.giftImage.isEmpty &&
                                occasionEntity.giftType == 'مبلغ مالي'
                            ? SizedBox()
                            : CachedNetworkImage(
                                imageUrl: occasionEntity.giftImage,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) {
                                  return occasionEntity.giftImage.isEmpty &&
                                          occasionEntity.giftType == 'مبلغ مالي'
                                      ? Image.asset(
                                          'assets/images/money_bag.png',
                                          fit: BoxFit.contain,
                                        )
                                      : const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        );
                                },
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// gift name
                      Text(
                        "اسم الهدية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.giftNameController,
                        hintText: '',
                        initialValue: occasionEntity.giftName.toString(),
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// gift link
                      Text(
                        "رابط الهدية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.giftLinkController,
                        hintText: '',
                        initialValue: occasionEntity.giftLink.toString(),
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// gift price
                      Text(
                        "سعر الهدية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.giftPriceController,
                        initialValue: occasionEntity.giftPrice.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// remaining balance
                      Text(
                        "المبلغ المتبقي",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.moneyAmountController,
                        initialValue: occasionEntity.moneyGiftAmount.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// bank name
                      Text(
                        "اسم البنك",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.bankNameController,
                        initialValue: occasionEntity.bankName.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// iban number
                      Text(
                        "رقم الآيبان",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.ibanController,
                        initialValue: occasionEntity.ibanNumber.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// bank name
                      Text(
                        "اسم المستلم",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.receiverNameController,
                        initialValue: occasionEntity.receiverName.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// bank name
                      Text(
                        "رقم جوال المستلم",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.receiverPhoneController,
                        initialValue: occasionEntity.receiverPhone.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// bank name
                      Text(
                        "المدينة",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.cityController,
                        initialValue: occasionEntity.city.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),

                      /// bank name
                      Text(
                        "الحي",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.districtController,
                        initialValue: occasionEntity.district.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      /// bank name
                      Text(
                        "بطاقة الهداية",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.giftCardController,
                        initialValue: occasionEntity.giftCard.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      /// bank name
                      Text(
                        "تاريخ الاستلام",
                        style: TextStyles.textStyle18Bold.copyWith(),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      DefaultTextField(
                        controller: cubit.receivingDateController,
                        initialValue: occasionEntity.receivingDate.toString(),
                        hintText: '',
                        validator: (value) {
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        fillColor: ColorManager.gray,
                        enable: true,
                      ),

                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),

                      state is UpdateOccasionsLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: DetailsButton(
                                iconColor: ColorManager.white,
                                title: 'تعديل المناسبة',
                                icon: Icons.edit,
                                onPressed: () {
                                  cubit.editOccasion(
                                      occasionId: occasionEntity.occasionId);
                                },
                                backGroundColor: ColorManager.warning,
                                foregroundColor: ColorManager.white,
                                textColor: ColorManager.white,
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
}
