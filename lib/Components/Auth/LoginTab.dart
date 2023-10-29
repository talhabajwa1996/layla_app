import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Models/AuthModels/LoginResponseModel.dart';
import 'package:layla_app_dev/Services/AuthServices/AuthServices.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Services/SharedPreferenceService/SharedPreferencesService.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Utils/Constants/KeysConstants.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Utils/HelperFunctions.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomElevatedButton.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:layla_app_dev/Widgets/TextFields/CustomTextFormField.dart';
import 'package:provider/provider.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/AppIcons.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Utils/Globals.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  GlobalKey<FormState>? _formKey;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Consumer<AuthController>(builder: (context, authController, child) {
          return Column(
            children: [
              SizedBox(
                height: 90,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localizedText(context)!.login_to_your_account,
                    style: const TextStyle(color: ColorConstants.textColorGrey, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              CustomTextFormField(
                hintText: localizedText(context)?.email,
                controller: _emailController,
                focusNode: _emailNode,
                onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_passwordNode),
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                onTap: () => FocusScope.of(context).requestFocus(_emailNode),
                validator: (String? value) => value!.isEmpty
                    ? "Please Enter your Email"
                    : !EmailValidator.validate(value)
                        ? "Please Enter a valid Email"
                        : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                hintText: localizedText(context)?.password,
                controller: _passwordController,
                focusNode: _passwordNode,
                isObscure: authController.isObscurePasswordLogin!,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                onTap: () => FocusScope.of(context).requestFocus(_passwordNode),
                suffixWidget: InkWell(
                  onTap: () => authController.toggleObscurePasswordLogin(),
                  child: Icon(
                    authController.isObscurePasswordLogin! ? AppIcons.eyeClosed : AppIcons.eyeOpen,
                    color: ColorConstants.textColorGrey,
                    size: 15.sp,
                  ),
                ),
                validator: (String? value) => (value!.isEmpty)
                    ? "Please Enter Password"
                    : value.length < 6
                        ? 'Password must contain at least 6 characters'
                        : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(RouteConstants.forgetPassword),
                      child: Text(localizedText(context)!.forget_password_ques,
                          style: const TextStyle(color: ColorConstants.textColorGrey, fontWeight: FontWeight.w500)))),
              const SizedBox(height: 20),
              authController.isLoginLoading!
                  ? const AppLoader()
                  : CustomElevatedButton.solid(
                      title: localizedText(context)?.login,
                      onPressed: () async {
                        if (_formKey!.currentState!.validate()) {
                          authController.setLoginLoading(true);
                          ShopifyService()
                              .shopifyAuth
                              .signInWithEmailAndPassword(email: _emailController!.text, password: _passwordController!.text)
                              .then((shopifyUserValue) async {
                            shopifyUser = shopifyUserValue;
                            showToast('Login Successful');
                            authController.setUserStatus = true;
                            await SharedPreferencesService().setString(KeysConstants.isUserLoggedIn, "true");
                            authController.setLoginLoading(false);
                            Navigator.of(context).pushReplacementNamed(RouteConstants.home);
                          }, onError: (error) {
                            authController.setLoginLoading(false);
                            showToast('Incorrect username or password');
                          });
                          // ServerResponse<LoginResponseModel> response =
                          //     await AuthServices().signInWithEmailAndPassword(
                          //         context,
                          //         email: _emailController!.text,
                          //         password: _passwordController!.text);
                          // if (response.status == Status.COMPLETED) {
                          //
                          // } else if (response.status == Status.ERROR) {
                          //
                          // }
                        }
                      }),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: ColorConstants.textColorGrey,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        localizedText(context)!.dont_have_an_account_yet,
                        style: const TextStyle(color: ColorConstants.textColorGrey),
                      ),
                    ),
                    const Expanded(
                        child: Divider(
                      color: ColorConstants.textColorGrey,
                    )),
                  ],
                ),
              ),
              CustomElevatedButton.outlined(
                  title: localizedText(context)?.signup,
                  onPressed: () {
                    authController.authTabController!.animateTo(1);
                    authController.setTabIndex(1);
                  }),
            ],
          );
        }),
      ),
    );
  }
}
