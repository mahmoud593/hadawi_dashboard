import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/banners/presentation/banners_screen.dart';
import 'package:hadawi_dathboard/features/auth/presentation/login_screen.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/occasions_screen.dart';
import 'package:hadawi_dathboard/styles/theme_manger/theme_manager.dart';
import 'package:hadawi_dathboard/utiles/cashe_helper/cashe_helper.dart';
import 'package:hadawi_dathboard/utiles/services/dio_helper.dart';
import 'package:hadawi_dathboard/utiles/services/notification_services.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/promocode/presentation/promocode_screen.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  SharedPreferences.getInstance();
  UserDataFromStorage.getData();
  CashHelper.init();
  DioHelper.dioInit();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices().getAccessToken();

  String languageCode = CashHelper.getData(key: CashHelper.languageKey).toString();
  debugPrint('debug $languageCode');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) => OccasionsCubit()..getOccasions(),
      child: BlocConsumer<OccasionsCubit, OccasionsState>(
          listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hadawi Dashboard',
            theme: getApplicationTheme(context),
            home:  const LoginScreen(),
          );
        },
      ),
    );
  }
}


