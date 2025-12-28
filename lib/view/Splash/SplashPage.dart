
import 'package:boilerplate_of_cubit/view/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';

import '../dashboard/dashboard.dart';
import '../transitation/transitaion.dart';
import 'cubit/splash_state.dart';


class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final MiscController _miscController = MiscController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SplashCubit()),
        ],
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {

            if (state.needLogin) {
              _miscController.navigateTo(context: context,page:  LoginPage());
            } else if (state.success) {
              _miscController.navigateTo(context: context, page: DashboardPage());
            }
          },
          builder: (context, state) {
            return Container(
              color: AppColors.primaryColor,
                child: Image.asset('assets/images/applogo.png',));
          },
        ));
  }

  //region dialog
  Future dialog({required BuildContext context, required bool success, required String message}) async {
    await _miscController.showGraphicalDialog(
        context: context,
        cancelable: false,
        imagePath: success ? 'assets/images/check.png' : 'assets/images/no.png',
        title: 'Attention Please',
        subTitle: message,
        okText: 'OKAY',
        okPressed: () {
          Navigator.pop(context);
        });
  }
//endregion
}
