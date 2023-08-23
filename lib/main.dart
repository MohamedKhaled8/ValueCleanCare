import 'helper/db_sh.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'helper/check_internet.dart';
import 'package:flutter/material.dart';
import 'services/localizatoion_service.dart';
import 'package:valueclean/translation/lang.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:valueclean/helper/caching_data.dart';
import 'package:valueclean/helper/secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valueclean/theme/constant/const_colors.dart';
import 'package:valueclean/view/spalsh_view/frist_splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Shared_Preference.init();
  await Secure_Storage.init();
  await checkInternetConnection();

  await CachingData.cachingLoginData();
  // await CachingData.userLogin();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put<LocaleService>((LocaleService()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(393, 852),
        builder: (context, child) {
          return GetMaterialApp(
            locale: localeService.handleLocaleInMain,
            title: 'ValU Clean'.tr,
            color: ColorApp.primary,
            debugShowCheckedModeBanner: false,
            home: const FristSplashScreen(),
            translations: AppTranslation(),
          );
        });
  }
}
