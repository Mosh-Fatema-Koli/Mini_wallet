import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constant.dart';
import 'login_state.dart';
import 'dart:math';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String pin) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2)); // mock API delay

    if (email == "test@gmail.com" && pin == "123456") {
      final prefs = await SharedPreferences.getInstance();

      // 🔐 Generate mock token
      final token = _generateMockToken();


      await prefs.setBool(Constant.isLoggedIn, true);
      await prefs.setString(Constant.accessToken, token);
      await prefs.setString(Constant.email, email);
      await prefs.setString(Constant.pin, pin);

      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Invalid email or PIN"));
    }
  }

  String _generateMockToken() {
    final rand = Random();
    return "mock_${DateTime.now().millisecondsSinceEpoch}_${rand.nextInt(999999)}";
  }
}
