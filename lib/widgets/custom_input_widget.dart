import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final double height;
  final double width;
  final IconData? inputIcon;
  final double borderRadiusValue;

  const CustomInputWidget({
      this.borderRadiusValue = 100,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      this.onChanged,
      this.validator,
      required this.height,
      required this.width,
      this.inputIcon,
      super.key});

  @override
  CustomInputWidgetState createState() => CustomInputWidgetState();
}

class CustomInputWidgetState extends State<CustomInputWidget> {
  bool _obscureText = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            onChanged: null,
            decoration:  InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(75, 75, 75, 1),
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(widget.borderRadiusValue)),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1), // Default border color
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                      color: Colors.blue, width: 2), // Border when focused
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                      color: Colors.red,
                      width: 2), // Border when there's an error
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
          ),
        ),
      ],
    );
  }
}
