// login/presentation/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_assessment/common/app_colors.dart';
import 'package:mobile_assessment/common/shared_styles.dart';
import 'package:mobile_assessment/modules/login/data/models/admin_model.dart';
import 'package:mobile_assessment/modules/login/data/repository/auth_repository.dart';
import 'package:mobile_assessment/modules/login/presentation/login_viewmodel.dart';
import 'package:mobile_assessment/modules/widgets/button/app_gradient_button.dart';
import 'package:mobile_assessment/modules/widgets/loading/loading.dart';
import 'package:mobile_assessment/modules/widgets/text/app_text.dart';
import 'package:mobile_assessment/modules/widgets/text/row_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final AuthRepository authRepository;
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<AdminModel?>(
            future: viewModel.getAdmin(),
            builder: (context, snapshot) {
              AdminModel? admin = snapshot.data;
              if (!snapshot.hasData) return Loading();
              return Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: myroundedBoxDecoration,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.orange.withOpacity(0.7),
                          child: Icon(
                            IconlyBold.user_2,
                            color: white,
                          )),
                    ),
                    AppText(
                      '${admin!.firstName} ${admin.lastName}',
                      textSize: AppTextSize.xbig,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RowText('Name:', '${admin!.firstName} ${admin.lastName}'),
                    RowText('Username: ', '${admin.username}'),
                    RowText('Designation: ', '${admin.designation}'),
                    RowText('Email: ', '${admin.email}'),
                    SizedBox(height: 200),
                    AppGradientButton(
                      buttonText: "Logout",
                      isOval: true,
                      widthRatio: 0.67,
                      onTap: () {
                        viewModel.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
