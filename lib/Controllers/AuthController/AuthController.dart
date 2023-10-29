import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  TabController? authTabController;
  int currentTabIndex = 0;
  bool isUserLoggedIn = false;

  bool? isObscurePasswordLogin;
  bool? isObscurePasswordSignup;
  bool? isObscureConfirmPasswordSignup;
  bool? isLoginLoading;
  bool? isSignupLoading;
  bool? isForgetPasswordLoading;

  set setUserStatus(value){
    isUserLoggedIn = value;
    notifyListeners();
  }

  toggleObscurePasswordLogin() {
    isObscurePasswordLogin = !isObscurePasswordLogin!;
    notifyListeners();
  }

  toggleObscurePasswordSignup() {
    isObscurePasswordSignup = !isObscurePasswordSignup!;
    notifyListeners();
  }

  toggleObscureConfirmPasswordSignup() {
    isObscureConfirmPasswordSignup = !isObscureConfirmPasswordSignup!;
    notifyListeners();
  }

  setLoginLoading(bool value) {
    isLoginLoading = value;
    notifyListeners();
  }

  setSignupLoading(bool value) {
    isSignupLoading = value;
    notifyListeners();
  }

  setForgetPasswordLoading(bool value) {
    isForgetPasswordLoading = value;
    notifyListeners();
  }

  setTabIndex(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  initialize(TickerProvider tickerProvider) {
    isObscurePasswordLogin = true;
    isObscurePasswordSignup = true;
    isObscureConfirmPasswordSignup = true;
    isLoginLoading = false;
    isSignupLoading = false;
    isForgetPasswordLoading = false;
    authTabController = TabController(length: 2, vsync: tickerProvider);
  }
}
