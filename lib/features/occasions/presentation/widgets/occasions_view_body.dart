import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/section_container.dart';

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
    String? selectedValue;
    return BlocBuilder<OccasionsCubit, OccasionsState>(
      builder: (context, state) {
        final cubit = context.read<OccasionsCubit>();
        return Column(
          children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: ColorManager.primaryBlue),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: Text(
                          selectedValue ?? 'Filter by',
                          style: TextStyles.textStyle18Medium,
                        ),
                        icon: Icon(Icons.filter_list_alt,
                            color: ColorManager.primaryBlue),
                        borderRadius: BorderRadius.circular(12.0),
                        items: [
                          DropdownMenuItem(
                              value: 'كل المناسبات',
                              child: Text('All occasions',
                                  style: TextStyles.textStyle18Medium
                                       )),
                          DropdownMenuItem(
                              value: 'مناسبات غير مكتملة',
                              child: Text('Not completed occasions',
                                  style: TextStyles.textStyle18Medium
                                       )),
                          DropdownMenuItem(
                              value: 'مناسبات مكتملة',
                              child: Text('Completed occasions',
                                  style: TextStyles.textStyle18Medium
                                       )),
                          DropdownMenuItem(
                              value: 'هدية',
                              child: Text('Gifts',
                                  style: TextStyles.textStyle18Medium
                                       )),
                          DropdownMenuItem(
                              value: 'مبلغ مالي',
                              child: Text('Money',
                                  style: TextStyles.textStyle18Medium
                                       )),
                        ],
                        onChanged: (value) {
                          if (value == 'هدية') {
                            setState(() {
                              selectedValue = value;
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
              height: 20,
            ),
            cubit.occasions.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryBlue,
                    ),
                  )
                : Expanded(
                    child: Container(
                      width: double.infinity,
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
                      child: Expanded(
                        child: Column(
                          children: [
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
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.top,
                                  children: [
                                    TableRow(
                                      children: [
                                        Expanded(
                                          child: Text('Occasion Name',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('Occasion Id',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('Occasion Date',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('Person Name',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('Occasion Type',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('Gift Type',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                        Expanded(
                                          child: Text('       Actions',
                                              style: TextStyles
                                                  .textStyle18Medium
                                                  .copyWith(
                                                      color:
                                                          ColorManager.white)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: cubit.occasions.length,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: Colors.grey,
                                  );
                                },
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].occasionName,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].occasionId,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].occasionDate,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].personName,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].occasionType,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                          child: Text(
                                        cubit.occasions[index].giftType,
                                        style: TextStyles.textStyle18Medium,
                                      )),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color:
                                                      ColorManager.primaryBlue),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.remove_red_eye,
                                                  color: Colors.grey),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
