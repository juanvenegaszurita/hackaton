import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/helpers/helpers.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/ui/public/reset_password_ui.dart';

class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;
    return ScaffoldGeneric(
      title: 'login.updateProfileTitle'.tr,
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
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: 'login.nameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                  ),
                  FormVerticalSpace(),
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
                  PrimaryButton(
                      labelText: 'login.updateUser'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: authController.firestoreUser.value!.uid,
                              name: authController.nameController.text,
                              email: authController.emailController.text,
                              photoUrl:
                                  authController.firestoreUser.value!.photoUrl,
                              owner: authController.firestoreUser.value!.owner);
                          _updateUserConfirm(context, _updatedUser,
                              authController.firestoreUser.value!.email);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'login.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = new TextEditingController();
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          'login.enterPassword'.tr,
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: 'login.passwordFormField'.tr,
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!))
              return 'validator.password'.tr;
            else
              return null;
          },
          obscureText: true,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text('login.cancel'.tr.toUpperCase()),
            onPressed: () {
              Get.back();
            },
          ),
          new TextButton(
            child: new Text('login.submit'.tr.toUpperCase()),
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}
