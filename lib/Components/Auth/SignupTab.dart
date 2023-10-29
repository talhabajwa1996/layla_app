import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layla_app_dev/Models/AuthModels/CreateAccountResponseModel.dart';
import 'package:layla_app_dev/Services/AuthServices/AuthServices.dart';
import 'package:layla_app_dev/Services/API/ServerResponse.dart';
import 'package:layla_app_dev/Services/ShopifyServices/ShopifyServices.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomElevatedButton.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:layla_app_dev/Widgets/TextFields/CustomTextFormField.dart';
import 'package:provider/provider.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/AppIcons.dart';
import '../../AppTheme/ColorConstants.dart';
import '../../Utils/HelperFunctions.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  GlobalKey<FormState>? _formKey;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  FocusNode? _firstNameNode;
  FocusNode? _lastNameNode;
  FocusNode? _emailNode;
  FocusNode? _passwordNode;
  FocusNode? _confirmPasswordNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Consumer<AuthController>(builder: (context, controller, child) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      localizedText(context)!.create_your_account,
                      style: const TextStyle(color: ColorConstants.textColorGrey, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                CustomTextFormField(
                  hintText: localizedText(context)?.first_name,
                  controller: _firstNameController,
                  focusNode: _firstNameNode,
                  onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_lastNameNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  onTap: () => FocusScope.of(context).requestFocus(_firstNameNode),
                  validator: (String? value) => value!.isEmpty ? "Please Enter your First Name" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: localizedText(context)?.last_name,
                  controller: _lastNameController,
                  focusNode: _lastNameNode,
                  onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_emailNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  onTap: () => FocusScope.of(context).requestFocus(_lastNameNode),
                  validator: (String? value) => value!.isEmpty ? "Please Enter your Last Name" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: localizedText(context)?.password,
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  isObscure: controller.isObscurePasswordSignup!,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  onTap: () => FocusScope.of(context).requestFocus(_passwordNode),
                  onFieldSubmit: (value) => FocusScope.of(context).requestFocus(_confirmPasswordNode),
                  suffixWidget: InkWell(
                    onTap: () => controller.toggleObscurePasswordSignup(),
                    child: Icon(
                      controller.isObscurePasswordSignup! ? AppIcons.eyeClosed : AppIcons.eyeOpen,
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
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: localizedText(context)?.confirm_password,
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordNode,
                  isObscure: controller.isObscureConfirmPasswordSignup!,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  onTap: () => FocusScope.of(context).requestFocus(_confirmPasswordNode),
                  suffixWidget: InkWell(
                    onTap: () => controller.toggleObscureConfirmPasswordSignup(),
                    child: Icon(
                      controller.isObscureConfirmPasswordSignup! ? AppIcons.eyeClosed : AppIcons.eyeOpen,
                      color: ColorConstants.textColorGrey,
                      size: 15.sp,
                    ),
                  ),
                  validator: (String? value) => (value != _passwordController!.text) ? "Password does not match" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 20),
                controller.isSignupLoading!
                    ? const AppLoader()
                    : CustomElevatedButton.solid(
                        title: localizedText(context)?.signup,
                        onPressed: () async {
                          if (_formKey!.currentState!.validate()) {
                            controller.setSignupLoading(true);
                            ShopifyService()
                                .shopifyAuth
                                .createUserWithEmailAndPassword(
                                    firstName: _firstNameController!.text,
                                    lastName: _lastNameController!.text,
                                    email: _emailController!.text,
                                    password: _passwordController!.text,
                                    acceptsMarketing: true)
                                .then((value) {
                              showToast('Account created Successfully');
                              controller.authTabController!.animateTo(0);
                              controller.setTabIndex(0);
                              controller.setSignupLoading(false);
                            }, onError: (error) {
                              showToast('Something went wrong');
                              controller.setSignupLoading(false);
                            });
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          localizedText(context)!.already_have_an_account_ques,
                          style: TextStyle(color: ColorConstants.textColorGrey),
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
                    title: localizedText(context)?.login,
                    onPressed: () {
                      controller.authTabController!.animateTo(0);
                      controller.setTabIndex(0);
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
