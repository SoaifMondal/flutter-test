import 'package:ez_navy_app/controller/usre_create_update_controller.dart';
import 'package:ez_navy_app/model/user_model.dart';
import 'package:ez_navy_app/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UsercreateUpadtePage extends StatelessWidget {
  bool type;
  UsersModel? user;

  final userCreateupdateController controller =
      Get.put(userCreateupdateController());
  UsercreateUpadtePage({required this.type, this.user, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(title: Text(type == true ? 'Create User' : 'update User')),
      body: Container(
        child: Column(
          children: [
            type == true
                ? Form(
                    key: controller.createUserFormKey,
                    child: Column(
                      children: [
                        CustomInputWidget(
                          controller: controller.userFirstnameController,
                          hintText: 'first name',
                          validator: (value) => controller.validateName(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(height: height * 0.020),
                        CustomInputWidget(
                          controller: controller.userLastnameController,
                          hintText: 'last name',
                          isPassword: false,
                          validator: (value) => controller.validateName(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(height: height * 0.020),
                        CustomInputWidget(
                          controller: controller.userEmailController,
                          hintText: 'Email id',
                          validator: (value) => controller.validateEmail(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(
                          width: width * 0.92,
                          height: height * 0.070,
                          child: TextButton(
                            onPressed: controller.createUser,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(11, 34, 62, 1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            child: const Text('Create User'),
                          ),
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: controller.updateUserFormKey,
                    child: Column(
                      children: [
                        CustomInputWidget(
                          controller: controller.updateuserFirstnameController,
                          hintText: 'first name',
                          validator: (value) => controller.validateName(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(height: height * 0.020),
                        CustomInputWidget(
                          controller: controller.updateuserLastnameController,
                          hintText: 'last name',
                          isPassword: false,
                          validator: (value) => controller.validateName(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(height: height * 0.020),
                        CustomInputWidget(
                          controller: controller.updateuserEmailController,
                          hintText: 'Email id',
                          validator: (value) => controller.validateEmail(value),
                          onChanged: (value) => null,
                          height: height * 0.070,
                          width: width * 0.92,
                        ),
                        SizedBox(
                          width: width * 0.92,
                          height: height * 0.070,
                          child: TextButton(
                            onPressed: () => controller.updateUser(user!.id!),
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(11, 34, 62, 1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            child: const Text('Update User'),
                          ),
                        ),
                      ],
                    )),
          ],
        ),
      ),
    );
  }
}
