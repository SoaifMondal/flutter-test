
import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget{

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final double height;
  final double width;
  final IconData? inputIcon;
  final String? newErrorText;

  const CustomInputWidget({
    this.newErrorText,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    required this.height,
    required this.width,
    this.inputIcon,
    super.key
  });

  @override
  CustomInputWidgetState createState() => CustomInputWidgetState();
}

class CustomInputWidgetState extends State<CustomInputWidget>{

  bool _obscureText = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    
    return
    Column(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100), 
            border: Border.all(color: const Color.fromRGBO(11, 34, 62, 0.2), width: 1),
          ),
          child: TextFormField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                _errorText = widget.validator != null ? widget.validator!(value) : null;
              });
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText, // Use hintText instead of labelText
              hintStyle: const TextStyle(
                color: Color.fromRGBO(75, 75, 75, 1),
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: (widget.height - 25) / 2, ),
              suffixIcon: 
                widget.isPassword ? 
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: const Color.fromRGBO(75, 75, 75, 1),
                      ),
                    ),
                  ) : 
                  widget.inputIcon != null ?
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(onPressed: null, icon: Icon(widget.inputIcon)),
                  ) : null,
            ),
            textAlignVertical: TextAlignVertical.center, // Aligns text and hint vertically
            obscureText: widget.isPassword && _obscureText,
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}