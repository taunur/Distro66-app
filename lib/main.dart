import 'package:distro66_app/config/app_color.dart';
import 'package:distro66_app/config/session.dart';
import 'package:distro66_app/presentation/pages/home_page.dart';
import 'package:distro66_app/presentation/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distro66',
      theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          )),
      home: FutureBuilder(
        future:
            checkLoginStatus(), // Ganti dengan metode yang sesuai untuk memeriksa status login
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Menampilkan tampilan loading jika sedang memuat data
            return const CircularProgressIndicator(); // Atau widget loading lainnya
          } else if (snapshot.data == false) {
            // Token belum ada atau pengguna belum pernah login
            return const IntroPage();
          } else {
            // Token sudah ada dan pengguna telah login
            return const HomePage();
          }
        },
      ),
    );
  }
}

// Metode untuk memeriksa status login atau mendapatkan token
Future<bool> checkLoginStatus() async {
  final token = await Session.getToken();
  return token != null;
}
