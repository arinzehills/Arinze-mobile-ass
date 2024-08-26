// login/presentation/login_screen.dart

import 'package:flutter/material.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/inputs/app_textfield.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';
import 'package:mobile_assessment/common/responsive/my_paddings.dart';
import 'package:mobile_assessment/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mobile_assessment/modules/home/presentation/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size(context).height * 0.4,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                      gradient:
                          LinearGradient(colors: AppColors.myPurpleGradient)),
                  child: Center(
                    child: AppText(
                      'Admin Login',
                      color: white,
                      type: AppTextSize.medium,
                      textSize: AppTextSize.xxbig,
                    ),
                  ),
                ),
                MyPaddings.responsivePadding(
                  context,
                  padding: 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: viewModel.usernameController,
                        labelText: 'Username', hintText: 'ds',
                        onSaved: (v) {},
                        // decoration: InputDecoration(labelText: 'Password'),
                        // obscureText: true,
                      ),
                      CustomTextField(
                        controller: viewModel.passwordController,
                        labelText: 'Password', hintText: 'ds',
                        onSaved: (v) {},
                        // decoration: InputDecoration(labelText: 'Password'),
                        // obscureText: true,
                      ),
                      SizedBox(height: 20),
                      AppGradientButton(
                        buttonText: "Login",
                        isOval: true,
                        loadingState: viewModel.isLoading,
                        onTap: () async {
                          bool success = await viewModel.login();
                          if (success) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.initialRoute);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: AppColors.danger,
                                  content: Text(viewModel.errorMessage ??
                                      'Login failed')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
