import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/controller/promocode_cubit.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/widgets/cpromo_code_bottom_sheet.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../styles/text_styles/text_styles.dart';
import '../../../../widgets/icon_button.dart';
import '../../../../widgets/table_header_text.dart';
import '../../../../widgets/toast.dart';

class PromoCodeBodyView extends StatelessWidget {
  const PromoCodeBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PromoCodeCubit>();

    return BlocConsumer<PromoCodeCubit, PromoCodeState>(
      listener: (context, state) {
        if(state is AddPromoCodeSuccessState){
          cubit.clearControllers();
          cubit.getPromoCodes().then((value) {
            Navigator.pop(context);
          },);

        }
      },
      builder: (context, state) {

        if (state is GetPromoCodesLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (cubit.promoCodes.isEmpty || state is GetPromoCodesErrorState) {
          return Center(
            child: Column(
              children: [
                Text('لا يوجد أكواد صخم', style: TextStyles.textStyle18Medium),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    createPromoCodeBottomSheet(
                      context: context,
                      cubit: cubit,
                      onGenerateCode: () {
                        cubit.generateRandomCode(length: 6);
                      },
                      addPromoCode: () {
                         if(cubit.bottomSheetFormKey.currentState!.validate()){
                           cubit.addPromoCode();
                         }
                      },
                      onChooseDate: () {
                        showDatePicker(
                          helpText: 'اختر تاريخ انتهاء الكود',
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                        ).then((value) => cubit.setCodeExpirationDate(
                            expirationDate: value!));
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      padding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: ColorManager.primaryBlue),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sync, color: ColorManager.primaryBlue),
                          SizedBox(width: 10),
                          Text('انشاء كود خصم',
                              style: TextStyles.textStyle18Medium),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    createPromoCodeBottomSheet(
                      context: context,
                      cubit: cubit,
                      onGenerateCode: () {
                        cubit.generateRandomCode(length: 6);
                      },
                      addPromoCode: () {
                        cubit.addPromoCode();
                      },
                      onChooseDate: () {
                        showDatePicker(
                          helpText: 'اختر تاريخ انتهاء الكود',
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) => cubit.setCodeExpirationDate(
                            expirationDate: value!));
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.sizeOf(context).height * 0.24,
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: ColorManager.primaryBlue),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sync, color: ColorManager.primaryBlue),
                          SizedBox(width: 10),
                          Text('انشاء كود خصم',
                              style: TextStyles.textStyle18Medium),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildHeaderText('كود الخصم'),
                        buildHeaderText('الرقم المرجعي لكود الخصم'),
                        buildHeaderText('عدد مرات استخدام الكود'),
                        buildHeaderText('أقصي عدد مرات الاستخدام'),
                        buildHeaderText('تاريخ الانتهاء'),
                        buildHeaderText('المناسبات'),
                        buildHeaderText('وحدة التحكم'),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        )),
                    child: ListView.separated(
                      itemCount: cubit.promoCodes.length,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      separatorBuilder: (_, __) => Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        final promoCodesList = cubit.promoCodes[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(promoCodesList.code,
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                  child: Text(promoCodesList.id,
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                  child: Text(promoCodesList.used.toString(),
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                  child: Text(promoCodesList.maxUsage.toString(),
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                  child: Text(promoCodesList.expiryDate ,
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                  child: Text(promoCodesList.occasions.join(',') ,
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: buildIconButton(
                                      Icons.delete, Colors.red, () {
                                    showDeleteDialog(
                                        context, cubit, promoCodesList.id);
                                  }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
void showDeleteDialog(
    BuildContext context, PromoCodeCubit cubit, String promoCodeId) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.white,
        elevation: 2,
        title: Text(
          'هل انت متأكد من حذف كود الخصم؟',
          style: TextStyles.textStyle18Medium
              .copyWith(color: ColorManager.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child: Text('تأكيد',
                style: TextStyles.textStyle18Medium
                    .copyWith(color: ColorManager.red)),
            onPressed: () {
              cubit.deletePromoCode(codeId: promoCodeId);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('إلغاء',
                style: TextStyles.textStyle18Medium
                    .copyWith(color: ColorManager.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}