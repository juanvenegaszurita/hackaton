import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackaton/ui/private/update_profile_ui.dart';
import 'package:get/get.dart';
import 'package:hackaton/ui/components/segmented_selector.dart';
import 'package:hackaton/controllers/controllers.dart';
import 'package:hackaton/ui/components/components.dart';
import 'package:hackaton/models/models.dart';
import 'package:hackaton/constants/constants.dart';

class SettingsUI extends GetResponsiveView {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneric(
      title: 'settings.title'.tr,
      maxWidth: screen.settings.desktopChangePoint,
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return GridResponsive(
      xl: 2,
      lg: 2,
      md: 2,
      sm: 1,
      xs: 1,
      children: [
        Text('settings.language'.tr),
        SizedBox(
          width: 310,
          child: DropdownPicker(
            menuOptions: Globals.languageOptions,
            selectedOption: LanguageController.to.currentLanguage,
            onChanged: (value) async {
              await LanguageController.to.updateLanguage(value!);
              Get.forceAppUpdate();
            },
          ),
        ),
        //languageListTile(),
        Text('settings.updateProfile'.tr),
        ElevatedButton(
          onPressed: () async {
            Get.to(UpdateProfileUI());
          },
          child: Text(
            'settings.updateProfile'.tr,
          ),
        ),
        Text('settings.signOut'.tr),
        ElevatedButton(
          onPressed: () {
            AuthController.to.signOut();
          },
          child: Text(
            'settings.signOut'.tr,
          ),
        ),
      ],
    );
  }

  languageListTile() {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text('settings.language'.tr),
        trailing: SizedBox(
          width: 310,
          child: DropdownPicker(
            menuOptions: Globals.languageOptions,
            selectedOption: controller.currentLanguage,
            onChanged: (value) async {
              await controller.updateLanguage(value!);
              Get.forceAppUpdate();
            },
          ),
        ),
      ),
    );
  }

  themeListTile() {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'settings.system'.tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: 'settings.light'.tr, icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: 'settings.dark'.tr, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text('settings.theme'.tr),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
