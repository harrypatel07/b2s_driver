import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/helper/validator-helper.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/provider/api_master.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class LoginPageViewModel extends ViewModelBase {
  TextEditingController _emailController = new TextEditingController();
  get emailController => _emailController;
  TextEditingController _passController = new TextEditingController();
  get passController => _passController;

  String _errorEmail;
  get errorEmail => _errorEmail;

  String _errorPass;
  get errorPass => _errorPass;

  bool _showPass = false;
  get showPass => _showPass;

  LoginPageViewModel() {
    //account demo
    _emailController.text = "sonnguyen@ts24corp.com";
    _passController.text = "123456";
    _emailController.addListener(() {
      if (_emailController.text.length > 1) isValidEmail();
    });
    _passController.addListener(() {
      if (_passController.text.length > 1) isValidInfo();
    });
  }

  void onTapShowPassword() {
    _showPass = !_showPass;
    this.updateState();
  }

  bool isValidEmail() {
    _errorEmail = null;
    var resultemail = Validator.validateEmail(_emailController.text);
    if (resultemail != null) {
      _errorEmail = resultemail;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidPass() {
    _errorPass = null;
    var resultpass = Validator.validatePassword(_passController.text);
    if (resultpass != null) {
      _errorPass = resultpass;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidInfo() {
    if (isValidEmail() && isValidPass()) {
      this.updateState();
      return true;
    }
    return false;
  }

  onSignInClicked() async {
    if (isValidInfo()) {
      //Kiểm tra login
      LoadingDialog.showLoadingDialog(
          context, translation.text("WAITING_MESSAGE.AUTH_ACCOUNT"));
      var _checkLogin = await api.checkLogin(
        username: _emailController.text.trim(),
        password: _passController.text.trim(),
      );
      if (_checkLogin == StatusCodeGetToken.TRUE) {
        // Lấy id của user
        var userInfo = await api.getUser();
        if (userInfo != null) {
          //Kiểm tra có phải driver
          bool result = await api.checkIsDriver(userInfo['partnerID']);
          if (!result) {
            LoadingDialog.hideLoadingDialog(context);
            return LoadingDialog.showMsgDialog(
                context, translation.text("ERROR_MESSAGE.PERMISSION_APP"));
          }
          //Lấy thông tin parent
          await api.getDriverInfo(userInfo['partnerID']);
        }
        LoadingDialog.hideLoadingDialog(context);
        // ToastController.show(
        //     context: context,
        //     duration: Duration(milliseconds: 200),
        //     message: translation.text("WAITING_MESSAGE.PERMISSION_CONNECT"));

        Navigator.pushReplacementNamed(context, TabsPage.routeName,
            arguments: TabsArgument(routeChildName: HomePage.routeName));
      } else {
        LoadingDialog.hideLoadingDialog(context);
        return LoadingDialog.showMsgDialog(
            context, translation.text("ERROR_MESSAGE.WRONG_LOGIN"));
      }
    }
  }
}
