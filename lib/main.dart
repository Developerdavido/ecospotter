
import 'package:citizen_app/core/presentation/ui/views/splash_page/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/env_config/env_config.dart';
import 'config/locator.dart';
import 'config/provider/providers.dart';
import 'config/services/local_storage_service.dart';
import 'config/services/supabase_service.dart';
import 'config/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await environment config
  await EnvConfig.initialize();
  //initialize supabase
  await SupabaseService.initialize();
  setupLocator();
  final prefs = await SharedPreferences.getInstance();
  CacheHelper.instance.init(prefs);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiProvider(
            providers: providers,
          builder: (context, child) {
              return GetMaterialApp(
                title: 'EWC Mobile App',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.appThemeData[AppTheme.darkTheme],
                home: const SplashScreen(),
              );
          },
        );
      },
    );
  }
}


