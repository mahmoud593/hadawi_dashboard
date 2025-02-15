import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/edit_occasion_screen.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/section_container.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/view_occasion_details.dart';
import 'package:hadawi_dathboard/widgets/icon_button.dart';

import '../../../../styles/colors/color_manager.dart';
import '../../../../styles/text_styles/text_styles.dart';

class OccasionsViewBody extends StatefulWidget {
  const OccasionsViewBody({super.key});

  @override
  State<OccasionsViewBody> createState() => _OccasionsViewBodyState();
}

class _OccasionsViewBodyState extends State<OccasionsViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionsCubit, OccasionsState>(
      builder: (context, state) {
        final cubit = context.read<OccasionsCubit>();

        if (state is GetOccasionsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (cubit.occasions.isEmpty || state is GetOccasionsErrorState) {
          return Center(
            child: Text('لا يوجد مناسبات', style: TextStyles.textStyle18Medium),
          );
        }

        return Expanded(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: ColorManager.primaryBlue),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: cubit.selectedValue,
                        hint: Text(
                          cubit.selectedValue ?? 'تصنيف حسب',
                          style: TextStyles.textStyle18Medium,
                        ),
                        icon: Icon(Icons.filter_list_alt,
                            color: ColorManager.primaryBlue),
                        borderRadius: BorderRadius.circular(12.0),
                        items: [
                          DropdownMenuItem(
                              value: 'كل المناسبات',
                              child: Text('كل المناسبات',
                                  style: TextStyles.textStyle18Medium)),
                          DropdownMenuItem(
                              value: 'مناسبات غير مكتملة',
                              child: Text('مناسبات غير مكتملة',
                                  style: TextStyles.textStyle18Medium)),
                          DropdownMenuItem(
                              value: 'مناسبات مكتملة',
                              child: Text('مناسبات مكتملة',
                                  style: TextStyles.textStyle18Medium)),
                          DropdownMenuItem(
                              value: 'هدية',
                              child: Text('هدية',
                                  style: TextStyles.textStyle18Medium)),
                          DropdownMenuItem(
                              value: 'مبلغ مالي',
                              child: Text('مبلغ مالي',
                                  style: TextStyles.textStyle18Medium)),
                        ],
                        onChanged: (value) {
                          if (value == 'هدية') {
                            setState(() {
                              cubit.selectedValue = value;
                            });
                            cubit.filterOccasionsByType(occasionType: 'هدية');
                          } else if (value == 'مبلغ مالي') {
                            cubit.filterOccasionsByType(
                                occasionType: 'مبلغ مالي');
                          } else if (value == 'مناسبات غير مكتملة') {
                            cubit.filterNotCompletedOccasions();
                          } else if (value == 'مناسبات مكتملة') {
                            cubit.filterCompletedOccasions();
                          } else {
                            cubit.getOccasions();
                          }
                        },
                      ),
                    ),
                  )),
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
                      buildHeaderText('المناسبة'),
                      buildHeaderText('الرقم المرجعي للمناسبة'),
                      buildHeaderText('تاريخ المناسبة'),
                      buildHeaderText('صاحب المناسبة'),
                      buildHeaderText('نوع المناسبة'),
                      buildHeaderText('نوع الهدية'),
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
                    )
                  ),
                  child: ListView.separated(
                    itemCount: cubit.occasions.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    separatorBuilder: (_, __) => Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      final occasion = cubit.occasions[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(occasion.occasionName,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                                child: Text(occasion.occasionId,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                                child: Text(occasion.occasionDate,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                                child: Text(occasion.personName,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                                child: Text(occasion.occasionType,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                                child: Text(occasion.giftType,
                                    style: TextStyles.textStyle18Medium)),
                            Expanded(
                              child: Row(
                                children: [
                                  buildIconButton(
                                      Icons.edit, ColorManager.primaryBlue, () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: cubit,
                                          child: EditOccasionScreen(
                                              occasionEntity: occasion),
                                        ),
                                      ),
                                    );
                                  }),
                                  buildIconButton(
                                      Icons.remove_red_eye, Colors.grey, () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewOccasionDetails(
                                            occasionEntity: occasion),
                                      ),
                                    );
                                  }),
                                  buildIconButton(Icons.delete, Colors.red, () {
                                    showDeleteDialog(
                                        context, cubit, occasion.occasionId);
                                  }),
                                ],
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
        );
      },
    );
  }

  Widget buildHeaderText(String text) {
    return Expanded(
      child: Text(text,
          style:
              TextStyles.textStyle18Medium.copyWith(color: ColorManager.white)),
    );
  }


  void showDeleteDialog(
      BuildContext context, OccasionsCubit cubit, String occasionId) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorManager.white,
          elevation: 2,
          title: Text(
            'هل انت متأكد من حذف المناسبة؟',
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
                cubit.deleteOccasion(occasionId: occasionId);
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
}
