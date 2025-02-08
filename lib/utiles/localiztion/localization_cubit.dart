// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hadawi_app/utiles/cashe_helper/cashe_helper.dart';
// import 'package:hadawi_app/utiles/localiztion/localization_states.dart';
//
// class LocalizationCubit extends Cubit<LocalizationStates>{
//
//   LocalizationCubit() : super(InitialState());
//
//   static LocalizationCubit get(context) => BlocProvider.of(context);
//
//   Locale _appLocale = const Locale('en');
//
//   Locale get appLocal => _appLocale;
//
//   Future<void> fetchLocalization()async{
//     String languageCode = CashHelper.getData(key: CashHelper.languageKey).toString();
//
//     if(languageCode == 'null' || languageCode == 'en'){
//       CashHelper.saveData(key: CashHelper.languageKey,value: "en");
//       CashHelper.saveData(key: CashHelper.languageNameKey,value: "langEnglish");
//       _appLocale = const Locale("en");
//       changeLanguage(code: "en");
//       debugPrint('default language is arabic');
//       emit(FetchLocalizationState());
//     }
//     else {
//       CashHelper.saveData(key: CashHelper.languageKey,value: "ar");
//       CashHelper.saveData(key: CashHelper.languageNameKey,value: "langArabic");
//       _appLocale = const Locale("ar");
//       changeLanguage(code: "ar");
//       debugPrint('default language is $languageCode');
//       emit(FetchLocalizationState());
//     }
//     emit(FetchLocalizationState());
//   }
//
//
//
//
//   Future<void> changeLanguage({required String code})async{
//     if(code =='ar'){
//       _appLocale = const Locale("ar");
//       CashHelper.saveData(key: CashHelper.languageKey,value: "ar");
//       CashHelper.saveData(key: CashHelper.languageNameKey,value: "langEnglish");
//       debugPrint('App language is Arabic');
//       emit(ChangeToArabicState());
//     }else {
//       _appLocale = const Locale("en");
//       CashHelper.saveData(key: CashHelper.languageKey,value: "en");
//       CashHelper.saveData(key: CashHelper.languageNameKey,value: "langArabic");
//       debugPrint('App language is English');
//       emit(ChangeToEnglishState());
//     }
//     emit(ChangeLanguageState());
//   }
//
//
//
// }