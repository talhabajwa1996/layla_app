import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/AuthController/AuthController.dart';
import 'package:layla_app_dev/Models/AuthModels/SendPasswordResetResponseModel.dart';
import 'package:layla_app_dev/Utils/Constants/ColorConstants.dart';
import 'package:layla_app_dev/Widgets/LogoAppBar.dart';
import 'package:layla_app_dev/Widgets/Notifiers/Toast.dart';
import 'package:provider/provider.dart';

import '../../Services/AuthServices/AuthServices.dart';
import '../../Services/API/ServerResponse.dart';
import '../../Utils/HelperFunctions.dart';
import '../../Widgets/Buttons/CustomElevatedButton.dart';
import '../../Widgets/Loaders/AppLoader.dart';
import '../../Widgets/TextFields/CustomTextFormField.dart';

class ForgetPasswordUI extends StatefulWidget {
  const ForgetPasswordUI({super.key});

  @override
  State<ForgetPasswordUI> createState() => _ForgetPasswordUIState();
}

class _ForgetPasswordUIState extends State<ForgetPasswordUI>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState>? _formKey;
  TextEditingController? _emailController;
  FocusNode? _emailNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _emailNode = FocusNode();
    Provider.of<AuthController>(context, listen: false).initialize(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logoAppBar(),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight!,
            child: Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryColor.withOpacity(0.3),
                        ColorConstants.primaryColor.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Consumer<AuthController>(
                    builder: (context, authController, child) {
                  return Card(
                    color: ColorConstants.white,
                    surfaceTintColor: Colors.transparent,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                localizedText(context)
                                    .forget_password
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: ColorConstants.textColorGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 130,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localizedText(context)
                                      .please_enter_email_will_send_password_reset,
                                  style: const TextStyle(
                                      color: ColorConstants.textColorGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              hintText: localizedText(context).email,
                              controller: _emailController,
                              focusNode: _emailNode,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.done,
                              onTap: () => FocusScope.of(context)
                                  .requestFocus(_emailNode),
                              validator: (String? value) => value!.isEmpty
                                  ? "Please Enter your Email"
                                  : !EmailValidator.validate(value)
                                      ? "Please Enter a valid Email"
                                      : null,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            const SizedBox(height: 20),
                            authController.isForgetPasswordLoading!
                                ? const AppLoader()
                                : CustomElevatedButton.solid(
                                    title: localizedText(context).submit,
                                    onPressed: () async {
                                      if (_formKey!.currentState!.validate()) {
                                        ServerResponse<SendPasswordResetResponseModel> response =
                                        await AuthServices().sendPasswordResetEmail(
                                            context, _emailController!.text);
                                        if (response.status == Status.COMPLETED) {
                                          showToast('A password reset link has been sent to your email');
                                          Navigator.of(context).pop();
                                        } else if (response.status == Status.ERROR) {
                                          showToast(response.message!);
                                        }
                                      }
                                    }),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          );
        }),
      ),
    );
  }
}
