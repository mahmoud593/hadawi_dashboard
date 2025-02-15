import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/banners/presentation/controller/banners_cubit.dart';
import 'package:hadawi_dathboard/features/banners/presentation/widgets/add_banners_screen.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import '../../../../widgets/icon_button.dart';
import '../../../users/presentation/widgets/users_view_body.dart';

class BannersScreenBody extends StatelessWidget {
  const BannersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        final cubit = context.read<BannersCubit>();
        if (state is GetBannersLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (cubit.banners.isEmpty || state is GetBannersErrorState) {
          return Center(
            child: Text('لا يوجد إعلانات حالياً\n يرجى اضافة إعلان',
                style: TextStyles.textStyle18Medium),
          );
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    customPushNavigator(
                        context,
                        BlocProvider.value(
                          value: cubit,
                          child: AddBannersScreen(),
                        ));
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.sizeOf(context).height * 0.2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryBlue,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: ColorManager.primaryBlue),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: ColorManager.white,
                              size: MediaQuery.sizeOf(context).height * 0.03,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).height * 0.02,
                            ),
                            Text(
                              'إضافة إعلان',
                              style: TextStyles.textStyle18Bold
                                  .copyWith(color: ColorManager.white),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),

                Container(
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 25),
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
                        buildHeaderText('صورة الاعلان'),
                        buildHeaderText('الرقم المرجعي للإعلان'),
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
                      itemCount: cubit.banners.length,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      separatorBuilder: (_, __) => Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        // final occasion = cubit.occasions[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: cubit.banners[index].image,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Text(cubit.banners[index].id,
                                      style: TextStyles.textStyle18Medium)),
                              Expanded(
                                child: Row(
                                  children: [
                                    buildIconButton(Icons.delete, Colors.red,
                                        () {
                                      showDeleteDialog(context, cubit,
                                          cubit.banners[index].id);
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
          ),
        );
      },
    );
  }
}
void showDeleteDialog(
    BuildContext context, BannersCubit cubit, String bannerId) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.white,
        elevation: 2,
        title: Text(
          'هل انت متأكد من حذف الإعلان؟',
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
              cubit.deleteBanner(bannerId: bannerId);
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

