import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/controllers/controllers.dart';

class HomeUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //print('user.name: ' + user?.value?.name);
    return ScaffoldGeneric(
      title: 'home.title'.tr,
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
                  // FormInputFieldWithIcon(),
                  FormVerticalSpace(),
                  //FormInputFieldWithIcon(),
                  FormVerticalSpace(),
                  FormVerticalSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
