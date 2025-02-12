import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/occastion_entity.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/edit_button.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/image_container.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/occasion_info_row.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class ViewOccasionDetails extends StatelessWidget {
  final OccasionEntity occasionEntity;

  const ViewOccasionDetails({super.key, required this.occasionEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorManager.white),
        backgroundColor: ColorManager.primaryBlue,
        centerTitle: true,
        title: Text(
          'تفاصيل المناسبة',
          style:
              TextStyles.textStyle18Medium.copyWith(color: ColorManager.white),
        ),
      ),
      body: Padding(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    DetailsButton(
                      title: "رجوع",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.arrow_back,
                      iconColor: ColorManager.white,
                      backGroundColor: ColorManager.primaryBlue,
                      foregroundColor: ColorManager.white,
                      textColor: ColorManager.white,
                    ),


                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.04,
                ),
                Text(
                  "صورة المناسبة",
                  style: TextStyles.textStyle18Bold.copyWith(
                    color: ColorManager.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// gift image
                occasionEntity.giftImage.isNotEmpty
                    ? ImageContainer(
                        imageUrl: occasionEntity.giftImage,
                      )
                    : Text("لا يوجد صورة", style: TextStyles.textStyle18Bold),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// occasion Id
                OccasionInfoColumn(
                  title: "الرقم المرجعي للمناسبة",
                  occasionValue: occasionEntity.occasionId,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// occasion name
                OccasionInfoColumn(
                  title: "اسم المناسبة",
                  occasionValue: occasionEntity.occasionName,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// person Name
                OccasionInfoColumn(
                  title: "اسم صاحب المناسبة",
                  occasionValue: occasionEntity.personName,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// person email
                OccasionInfoColumn(
                  title: "حساب صاحب المناسبة",
                  occasionValue: occasionEntity.personEmail,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// person phone
                OccasionInfoColumn(
                  title: "رقم جوال صاحب المناسبة",
                  occasionValue: occasionEntity.personPhone,
                ),

                /// occasion date
                OccasionInfoColumn(
                  title: "تاريخ المناسبة",
                  occasionValue: occasionEntity.occasionDate,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// occasion type
                OccasionInfoColumn(
                  title: "نوع المناسبة",
                  occasionValue: occasionEntity.occasionType,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// occasion type
                OccasionInfoColumn(
                  title: "اسم الهدية",
                  occasionValue: occasionEntity.giftName,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// gift type
                OccasionInfoColumn(
                  title: "نوع الهدية",
                  occasionValue: occasionEntity.giftType,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),

                /// gift price
                OccasionInfoColumn(
                    title: "سعر الهدية",
                    occasionValue: "${occasionEntity.giftPrice} ريال"),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
