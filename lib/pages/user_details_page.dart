import 'package:ez_navy_app/controller/user_details_controller.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsPage extends StatelessWidget {
  final userID;

  UserDetailsPage({required this.userID, super.key});

  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchUser(userID.id);

    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;
        if (user == null) {
          return const Center(child: Text("User not found"));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  '${user.avatar}',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'User ID: ${user.id}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Name: ${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 5),
              Text('Email: ${user.email}',
                  style: const TextStyle(fontSize: 16)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RoutesName.userUpdatePage,
                    );
                  },
                  child: Text('Update user'))
            ],
          ),
        );
      }),
    );
  }
}
