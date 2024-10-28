import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locall/common/widgets/custom_appbar.dart';
import 'package:locall/common/widgets/image_viewer.dart';
import 'package:locall/features/authentication/controllers/registration_screen_controller.dart';

class ShopRegistrationScreen extends StatelessWidget {
  const ShopRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<RegistrationScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("Register your Shop"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [_shopImages()],
          ),
        ),
      ),
    );
  }

  Widget _shopImages() {
    return SizedBox(
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
          ImageViewer(
            onRemove: () {},
            onAdd: () {},
          ),
        ],
      ),
    );
  }
}
