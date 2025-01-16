import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/colors.dart';
import 'package:wallpaper_app/view/screens/splash.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WallpaperProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          scaffoldBackgroundColor: AppColors.primaryColor,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.secounderyColor),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
