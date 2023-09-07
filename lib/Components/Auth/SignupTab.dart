import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Services/AuthServices/AuthServices.dart';
import 'package:layla_app_dev/Services/ServerResponse.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomElevatedButton.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:layla_app_dev/Widgets/TextFields/CustomTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/models/models.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/AppIcons.dart';
import '../../Utils/Constants/ColorConstants.dart';

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
          child:
              Consumer<AuthController>(builder: (context, controller, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "CREATE YOUR ACCOUNT",
                      style: TextStyle(
                          color: ColorConstants.textColorGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                CustomTextFormField(
                  hintText: 'First Name',
                  controller: _firstNameController,
                  focusNode: _firstNameNode,
                  onFieldSubmit: (value) =>
                      FocusScope.of(context).requestFocus(_lastNameNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_firstNameNode),
                  validator: (String? value) =>
                      value!.isEmpty ? "Please Enter your First Name" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Last Name',
                  controller: _lastNameController,
                  focusNode: _lastNameNode,
                  onFieldSubmit: (value) =>
                      FocusScope.of(context).requestFocus(_emailNode),
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_lastNameNode),
                  validator: (String? value) =>
                      value!.isEmpty ? "Please Enter your Last Name" : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Email',
                  controller: _emailController,
                  focusNode: _emailNode,
                  onFieldSubmit: (value) =>
                      FocusScope.of(context).requestFocus(_passwordNode),
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
                  hintText: 'Password',
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  isObscure: controller.isObscurePasswordSignup!,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_passwordNode),
                  onFieldSubmit: (value) =>
                      FocusScope.of(context).requestFocus(_confirmPasswordNode),
                  suffixWidget: InkWell(
                    onTap: () => controller.toggleObscurePasswordSignup(),
                    child: Icon(
                        controller.isObscurePasswordSignup!
                            ? AppIcons.eyeClosed
                            : AppIcons.eyeOpen,
                        color: ColorConstants.textColorGrey),
                  ),
                  validator: (String? value) => (value!.isEmpty)
                      ? "Please Enter Password"
                      : value.length < 8
                          ? 'Password must contain at least 8 characters'
                          : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordNode,
                  isObscure: controller.isObscureConfirmPasswordSignup!,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_confirmPasswordNode),
                  suffixWidget: InkWell(
                    onTap: () =>
                        controller.toggleObscureConfirmPasswordSignup(),
                    child: Icon(
                        controller.isObscureConfirmPasswordSignup!
                            ? AppIcons.eyeClosed
                            : AppIcons.eyeOpen,
                        color: ColorConstants.textColorGrey),
                  ),
                  validator: (String? value) =>
                      (value != _passwordController!.text)
                          ? "Password does not match"
                          : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                const SizedBox(height: 20),
                controller.isSignupLoading!
                    ? const AppLoader()
                    : CustomElevatedButton.solid(
                        title: 'Sign up',
                        onPressed: () async {
                          if (_formKey!.currentState!.validate()) {
                            ServerResponse<ShopifyUser> response =
                                await AuthServices()
                                    .createUserWithEmailAndPassword(context,
                                        email: _emailController!.text,
                                        password: _passwordController!.text);
                            if (response.status == Status.COMPLETED) {
                              debugPrint(
                                  response.responseData!.toJson().toString());
                              controller.authTabController!.animateTo(0);
                              controller.setTabIndex(0);
                              showToast('Account created Successfully');
                            } else if (response.status == Status.ERROR) {
                              showToast('Error creating the account');
                            }
                          }
                        }),
                const SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: ColorConstants.textColorGrey,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(color: ColorConstants.textColorGrey),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: ColorConstants.textColorGrey,
                      )),
                    ],
                  ),
                ),
                CustomElevatedButton.outlined(
                    title: 'Login',
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
