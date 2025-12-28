import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/Constant.dart';
import '../../../core/MiscController.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(SplashState(
    needLogin: false,
    success: false,
    message: '',
  )) {
    checkSession();
  }

  final _miscController = MiscController();

  Future<void> checkSession() async {
    await _miscController.delayed(millisecond: 1500);

    final pref = await _miscController.pref();

    final token = pref.getString(Constant.accessToken);
    final userInfoString =
    _miscController.prefGetString(pref: pref, key: Constant.userInfoPref);

    // 1️⃣ No token or empty → force login
    if (token == null || token.isEmpty) {
      emit(SplashState(
        needLogin: true,
        success: false,
        message: "No session found",
      ));
      return;
    }else{
      emit(SplashState(
        needLogin: false,
        success: true,
        message: "No session found",
      ));
    }


  }
}
