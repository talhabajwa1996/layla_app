import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Services/AuthServices/AuthServices.dart';
import 'package:layla_app_dev/Services/ServerResponse.dart';
import 'package:layla_app_dev/Utils/Constants/RouteConstants.dart';
import 'package:layla_app_dev/Widgets/Buttons/CustomElevatedButton.dart';
import 'package:layla_app_dev/Widgets/Loaders/AppLoader.dart';
import 'package:layla_app_dev/Widgets/TextFields/CustomTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:shopify_flutter/models/models.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/AppIcons.dart';
import '../../Utils/Constants/ColorConstants.dart';

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
        child: Consumer<AuthController>(builder: (context, controller, child) {
          return Column(
            children: [
              const SizedBox(
                height: 90,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LOGIN TO YOUR ACCOUNT",
                    style: TextStyle(
                        color: ColorConstants.textColorGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
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
              const SizedBox(height: 30),
              CustomTextFormField(
                hintText: 'Password',
                controller: _passwordController,
                focusNode: _passwordNode,
                isObscure: controller.isObscurePasswordLogin!,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                onTap: () => FocusScope.of(context).requestFocus(_passwordNode),
                suffixWidget: InkWell(
                  onTap: () => controller.toggleObscurePasswordLogin(),
                  child: Icon(
                      controller.isObscurePasswordLogin!
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
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {},
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                              color: ColorConstants.textColorGrey,
                              fontWeight: FontWeight.w500)))),
              const SizedBox(height: 20),
              controller.isLoginLoading!
                  ? const AppLoader()
                  : CustomElevatedButton.solid(
                      title: 'Login',
                      onPressed: () async {
                        if (_formKey!.currentState!.validate()) {
                          ServerResponse<ShopifyUser> response =
                              await AuthServices().signInWithEmailAndPassword(
                                  context,
                                  email: _emailController!.text,
                                  password: _passwordController!.text);
                          if (response.status == Status.COMPLETED) {
                            debugPrint(
                                response.responseData!.toJson().toString());
                            Navigator.of(context)
                                .pushReplacementNamed(RouteConstants.home);
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
                        "Don't have an account yet?",
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
                  title: 'Sign up',
                  onPressed: () {
                    controller.authTabController!.animateTo(1);
                    controller.setTabIndex(1);
                  })
            ],
          );
        }),
      ),
    );
  }
}
