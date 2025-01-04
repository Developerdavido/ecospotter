
import 'package:citizen_app/core/presentation/ui/views/splash_page/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/services/local_storage_service.dart';
import 'core/config/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final prefs = await SharedPreferences.getInstance();
  // CacheHelper.instance.init(prefs);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'EWC Mobile App',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.appThemeData[AppTheme.darkTheme],
          home: const SplashScreen(),
        );
      },
    );
  }
}


