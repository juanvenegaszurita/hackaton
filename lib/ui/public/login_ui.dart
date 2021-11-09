import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/constants/globals.dart';
import 'package:hackaton/controller/auth_controller.dart';
import 'package:hackaton/controller/language_controller.dart';
import 'package:hackaton/helpers/validator.dart';
import 'package:hackaton/ui/components/components.dart';

class LoginUi extends GetResponsiveView {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return ScaffoldGeneric(
      maxWidth: screen.settings.tabletChangePoint,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'login.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'login.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'login.signInButton'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithEmailAndPassword(context);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'login.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(/* ResetPasswordUI() */ ""),
                  ),
                  LabelButton(
                    labelText: 'login.signUpLabelButton'.tr,
                    onPressed: () => Get.to(/* SignUpUI() */ ""),
                  ),
                  languageListTile(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => Center(
        child: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }
}
