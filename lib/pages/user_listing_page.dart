import 'package:ez_navy_app/controller/user_list_controller.dart';
import 'package:ez_navy_app/model/user_model.dart';
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListinPage extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  UserListinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drawer List')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Create user'),
              onTap: () {
                 Navigator.of(context).pushNamed(
          RoutesName.userCreatePage, 
        );
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return UserBox(user: user);
            },
          ),
        );
      }),
    );
  }
}



class UserBox extends StatelessWidget {
  final UsersModel user;

  const UserBox({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          RoutesName.userDetailspage,
          arguments: user, 
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImg(height: 80, imagePath: user.avatar ?? ""),
              const SizedBox(height: 10),
              Text(
                "${user.firstName} ${user.lastName}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                user.email ?? "",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class ProfileImg extends StatelessWidget {
  final double height;
  final String imagePath;

  const ProfileImg({required this.height, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imagePath,
        height: height,
        width: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
