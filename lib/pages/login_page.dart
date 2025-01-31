
import 'package:ez_navy_app/routes/routes.dart';
import 'package:ez_navy_app/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_input_widget.dart';

class LoginPage extends StatelessWidget{

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    double width=size.width;
    double height =size.height;
    return
      Scaffold(
        body: 
        SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    height: 48/30,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(11, 34, 62, 1),
                  ),
                ),
                const Text(
                  'Enter your credential to continue',
                  style: TextStyle(
                    height: 20.16/16,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(75, 75, 75, 1),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: FormField(),
                ),
              ],
            ),
          ),
        )
      );
    
  }
}

class FormField extends StatefulWidget {
  const FormField({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FormField> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<CustomInputWidgetState> usernameKey = GlobalKey();
  final GlobalKey<CustomInputWidgetState> passwordKey = GlobalKey();

  bool _isLoading = false;

  // login function start
  Future<void> _login() async {

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if(username.isNotEmpty && password.isNotEmpty){

      setState(() {
        _isLoading = true;
      });

      // API request
      final response = await http.post(
        Uri.parse('https://app.ef-tm.com/v1//public/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": username, "password": password}),
      );

      if (response.statusCode == 200) {
        // Parse the response
        final data = jsonDecode(response.body);

        if (data['data']['user']['accessToken'] != null) {
          // Navigate to Home Page
          pushReplacement(routeName: RoutesName.produtcsPage);
        } else {
          _showError('Login failed. Please check your credentials.');
        }
      } else if(response.statusCode == 412) {
        _showError('Login failed. Please enter correct user details.');
      }

    }else{
      usernameKey.currentState?.validate();
      passwordKey.currentState?.validate();
    }
  }
  // login function end

  // showError function start
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style:  TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(11, 34, 62, 1),
              foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    setState(() {
      _isLoading = false;
    });
  }
  // showError function end

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return(
        Column(
          children:[
            CustomInputWidget(
              key: usernameKey,
              controller: _usernameController,
              hintText: 'Email',
              validator: (value) => value == null || value.isEmpty ? 'Username is required' : null,
              height: height*0.070,
              width: width*0.92,
            ),
            SizedBox(height: height*0.020,),
            CustomInputWidget(
              key: passwordKey,
              controller: _passwordController,
              hintText: 'Password',
              isPassword: true,
              validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
              height: height*0.070,
              width: width*0.92,
            ),
            SizedBox(height: height*0.020,),
            _isLoading
                ? const CircularProgressIndicator(color: Color.fromRGBO(11, 32, 62, 1),)
                : SizedBox(
                    width: width*0.92,
                    height: height*0.070,
                    child: TextButton(
                      onPressed: _login, 
                      style: TextButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(11, 34, 62, 1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100), 
                          ),
                      ),
                      child: const Text('Log in'),
                    ),
                )
          ]
        )
    );
  }
}