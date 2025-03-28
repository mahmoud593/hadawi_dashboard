import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/domain/entities/occastion_entity.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/edit_button.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/image_container.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/occasion_info_row.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/received_package_details.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../../styles/assets/asset_manager.dart';

class ViewOccasionDetails extends StatefulWidget {
  final OccasionEntity occasionEntity;

  const ViewOccasionDetails({super.key, required this.occasionEntity});

  @override
  State<ViewOccasionDetails> createState() => _ViewOccasionDetailsState();
}

class _ViewOccasionDetailsState extends State<ViewOccasionDetails> {
  bool haveQrcode = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar:
            dashboardAppBarWidget(context: context, text: 'تفاصيل المناسبة'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DetailsButton(
                        title: "انشاء Qr Code",
                        onPressed: () async {
                          setState(() {
                            haveQrcode = true;
                          });
                        },
                        icon: Icons.qr_code_2,
                        iconColor: ColorManager.white,
                        backGroundColor: ColorManager.primaryBlue,
                        foregroundColor: ColorManager.white,
                        textColor: ColorManager.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      widget.occasionEntity.moneyGiftAmount >=
                              widget.occasionEntity.giftPrice
                          ? DetailsButton(
                              title: "عرض المناسبة بعد التوصيل",
                              onPressed: () async {
                                context
                                    .read<OccasionsCubit>()
                                    .getReceivedOccasions(
                                        occasionId:
                                            widget.occasionEntity.occasionId)
                                    .then(
                                  (value) {
                                    customPushNavigator(
                                        context,
                                        ReceivedPackageDetails(
                                          occasionId:
                                              widget.occasionEntity.occasionId,
                                        ));
                                  },
                                );
                              },
                              icon: Icons.wallet_giftcard_rounded,
                              iconColor: ColorManager.white,
                              backGroundColor: ColorManager.primaryBlue,
                              foregroundColor: ColorManager.white,
                              textColor: ColorManager.white,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),

                  haveQrcode == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.send_sharp,
                                  color: ColorManager.primaryBlue,
                                )),
                            Text(
                              "Qr Code الخاص بالمناسبه",
                              style: TextStyles.textStyle18Bold.copyWith(
                                color: ColorManager.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      : Column(),

                  haveQrcode == true
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        )
                      : Container(),

                  haveQrcode == true
                      ? SizedBox(
                          height: SizeConfig.height * 0.2,
                          width: SizeConfig.width * 0.15,
                          child: PrettyQrView.data(
                            data: widget.occasionEntity.occasionId,
                            decoration: const PrettyQrDecoration(
                              image: PrettyQrDecorationImage(
                                image: AssetImage(
                                    AssetsManager.logoWithoutBackground),
                              ),
                            ),
                          ),
                        )
                      : Container(),

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
                  widget.occasionEntity.giftImage.isNotEmpty
                      ? ImageContainer(
                          imageUrl: widget.occasionEntity.giftImage,
                        )
                      : Text("لا يوجد صورة", style: TextStyles.textStyle18Bold),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),

                  /// occasion Id
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            OccasionInfoColumn(
                              title: "الرقم المرجعي للمناسبة",
                              occasionValue: widget.occasionEntity.occasionId,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion name
                            OccasionInfoColumn(
                              title: "اسم المناسبة",
                              occasionValue: widget.occasionEntity.occasionName,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person Name
                            OccasionInfoColumn(
                              title: "اسم صاحب المناسبة",
                              occasionValue: widget.occasionEntity.personName,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person email
                            OccasionInfoColumn(
                              title: "حساب صاحب المناسبة",
                              occasionValue: widget.occasionEntity.personEmail,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person phone
                            OccasionInfoColumn(
                              title: "رقم جوال صاحب المناسبة",
                              occasionValue: widget.occasionEntity.personPhone,
                            ),

                            /// occasion date
                            OccasionInfoColumn(
                              title: "تاريخ المناسبة",
                              occasionValue: widget.occasionEntity.occasionDate,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion type
                            OccasionInfoColumn(
                              title: "نوع المناسبة",
                              occasionValue: widget.occasionEntity.occasionType,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion type
                            OccasionInfoColumn(
                              title: "اسم الهدية",
                              occasionValue: widget.occasionEntity.giftName,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// gift type
                            OccasionInfoColumn(
                              title: "نوع الهدية",
                              occasionValue: widget.occasionEntity.giftType,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// gift price
                            OccasionInfoColumn(
                                title: "سعر الهدية",
                                occasionValue:
                                    "${widget.occasionEntity.giftPrice} ريال"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            OccasionInfoColumn(
                              title: "اسم البنك",
                              occasionValue: widget.occasionEntity.bankName,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion name
                            OccasionInfoColumn(
                              title: "رقم الآيبان",
                              occasionValue: widget.occasionEntity.ibanNumber,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person Name
                            OccasionInfoColumn(
                              title: "اسم المستلم",
                              occasionValue: widget.occasionEntity.receiverName,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person email
                            OccasionInfoColumn(
                              title: "رقم جوال المستلم",
                              occasionValue:
                                  widget.occasionEntity.receiverPhone,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// person phone
                            OccasionInfoColumn(
                              title: "المدينة",
                              occasionValue: widget.occasionEntity.city,
                            ),

                            /// occasion date
                            OccasionInfoColumn(
                              title: "الحي",
                              occasionValue: widget.occasionEntity.district,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion type
                            OccasionInfoColumn(
                              title: "بطاقة الهداية",
                              occasionValue: widget.occasionEntity.giftCard,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),

                            /// occasion type
                            OccasionInfoColumn(
                              title: "تاريخ الاستلام",
                              occasionValue:
                                  widget.occasionEntity.receivingDate,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
