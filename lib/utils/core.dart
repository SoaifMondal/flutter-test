import 'package:get/get_utils/src/get_utils/get_utils.dart';

class ProductArgument{
  final int productID;
  const ProductArgument({required this.productID});
}

mixin InputValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Use a regex to check if the entered email is valid.
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}