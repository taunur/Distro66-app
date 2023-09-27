import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:distro66_app/config/app_asset.dart';
import 'package:distro66_app/config/app_color.dart';
import 'package:distro66_app/data/sources/source_user.dart';
import 'package:distro66_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void login() async {
    if (mounted && formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      bool success = await SourceUser.login(
        controllerUsername.text,
        controllerPassword.text,
      );

      setState(() {
        isLoading = false; // Hide loading indicator
      });

      if (mounted) {
        if (success) {
          DInfo.dialogSuccess(context, "Berhasil Login");
          DInfo.closeDialog(context, actionAfterClose: () {
            Get.offAll(() => const HomePage());
          });
        } else {
          DInfo.dialogError(context, "Gagal Login");
          DInfo.closeDialog(context);
        }
      }
    }
  }

  @override
  void dispose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Image.asset(
                    AppAsset.logo2,
                    height: 120,
                  ),
                  DView.spaceHeight(40),
                  TextFormField(
                    controller: controllerUsername,
                    validator: (value) => value == "" ? "Don't Empty" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Masukkan Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  DView.spaceHeight(),
                  TextFormField(
                    controller: controllerPassword,
                    obscureText:
                        !isPasswordVisible, // Gunakan isPasswordVisible untuk mengatur visibilitas
                    validator: (value) => value == "" ? "Don't Empty" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            togglePasswordVisibility, // Tambahkan fungsi untuk mengganti visibilitas password
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  DView.spaceHeight(),
                  Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "Username demo : ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "johnd",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Password demo : ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "m38rmF\$",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  DView.spaceHeight(36),
                  ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isLoading
                            ? AppColor.primary.withOpacity(0.5)
                            : AppColor.primary,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 42,
                        vertical: 16,
                      ),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DView.spaceWidth(8),
                                const Text(
                                  "Loading...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                    ),
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
