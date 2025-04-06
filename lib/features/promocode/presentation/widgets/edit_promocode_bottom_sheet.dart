import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/promocode/domain/entities/code_entity.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/controller/promocode_cubit.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

Future editPromoCodeBottomSheet({
  required BuildContext context,
  required PromoCodeCubit cubit,
  required void Function() onChooseDate,
  required CodeEntity codeEntity,
}) async {
  await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.02,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: cubit.editBottomSheetFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// container
                    Center(
                      child: Container(
                        width: MediaQuery.sizeOf(context).height * 0.2,
                        height: MediaQuery.sizeOf(context).height * 0.005,
                        decoration: ShapeDecoration(
                          color: ColorManager.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),

                    /// add code text
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('تعديل كود الخصم',
                              style: TextStyles.textStyle18Medium),
                        )),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),

                    /// code text field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.35,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        child: DefaultTextField(
                            controller: cubit.codeController,
                            hintText: 'أدخل كود الخصم',
                            enable: true,
                            initialValue: codeEntity.code,
                            validator: (value) {
                              if (!cubit.validateCode(value: value ?? '')) {
                                return cubit.state is ValidateCodeFailureState
                                    ? (cubit.state as ValidateCodeFailureState).message
                                    : null;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.transparent),
                      ),
                    ),

                    /// max use text field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        child: DefaultTextField(
                            controller: cubit.maxUseController,
                            hintText: 'أدخل أقصي عدد مرات استخدام الكود',
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'الرجاء ادخال أقصي عدد مرات استخدام الكود';
                              }
                              return null;
                            },
                            initialValue: codeEntity.maxUsage.toString(),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.transparent),
                      ),
                    ),

                    /// discount text field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        child: DefaultTextField(
                            controller: cubit.discountController,
                            hintText: 'أدخل الخصم',
                            initialValue: codeEntity.discount.toString(),
                            validator: (value) {
                              if(value!.trim().isEmpty){
                                return 'الرجاء ادخال الخصم';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.transparent),
                      ),
                    ),

                    /// expiration date text field
                    GestureDetector(
                      onTap: onChooseDate,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          child: DefaultTextField(
                              controller: cubit.expirationDateController,
                              initialValue: codeEntity.expiryDate,
                              hintText: 'تاريخ انتهاء الكود',
                              validator: (value) {
                                return cubit.validateExpirationDate();
                              },
                              enable: false,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              fillColor: Colors.transparent),
                        ),
                      ),
                    ),

                    /// add button
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.06,
                        child: DefaultButton(
                          buttonText: 'تعديل',
                          onPressed: () {
                            if (cubit.editBottomSheetFormKey.currentState!.validate()) {
                              cubit.editPromoCode(codeId: codeEntity.id);
                            }
                          },
                          buttonColor: ColorManager.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
}
