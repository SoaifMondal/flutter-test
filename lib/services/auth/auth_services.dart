

import 'package:ez_navy_app/constant/api_url.dart';
import 'package:ez_navy_app/model/api_base_data_model.dart';
import 'package:ez_navy_app/services/api/http_services.dart';

class AuthServices {
  // final HttpService _httpService = HttpService();

  // Future<ApiBaseDataModel> getEmployeeProfile(
  //     {required String jwtToken}) async {
  //   try {
  //     return await _httpService.getRequest(
  //       ApiUrls.getEmployeeProfile,
  //       token: jwtToken,
  //     );
  //   } catch (e) {
  //     return ApiBaseDataModel(status: false);
  //   }
  // }

  // ----------------------------------------------------------------------- //
  // -------------------Ignore below end points----------------------------- //
  // ----------------------------------------------------------------------- //
  // Sign Up using email or phone
//   Future<ApiBaseDataModel> userSignUp({
//     required String name,
//     required String emailOrPhone,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     return await _httpService.postRequestFormData(ApiUrls.signUpUrl,
//         data: {
//           'name': name,
//           'email': emailOrPhone,
//           'password': password,
//           'password_confirmation': confirmPassword,
//         },
//         token: '');
//   }

//   // Verify OTP

//   Future<ApiBaseDataModel> verifyOtp({
//     required String emailOrPhone,
//     required String otp,
//   }) async {
//     return await _httpService.postRequestFormData(ApiUrls.verifyOtp,
//         data: {'email': emailOrPhone, 'otp': otp}, token: '');
//   }

//   // Resend OTP

//   Future<ApiBaseDataModel> resendOtp({
//     required String emailOrPhone,
//     required String resendOtpType,
//     required String type,
//   }) async {
//     return await _httpService.postRequestFormData(ApiUrls.resendOtp,
//         data: {
//           'email': emailOrPhone,
//           'verification_method': resendOtpType,
//           'type': type,
//         },
//         token: '');
//   }

//   // Log in with email or phone

//   Future<ApiBaseDataModel> logInUser({
//     required String emailOrPhone,
//     required String password,
//   }) async {
//     return await _httpService.postRequestFormData(ApiUrls.logInUrl,
//         data: {
//           'email': emailOrPhone,
//           'password': password,
//         },
//         token: '');
//   }

//   // Forgot Password Verify email/phone and send otp
//   Future<ApiBaseDataModel> forgotPasswordSendOtp({
//     required String emailOrPhone,
//     required String verificationMethod,
//   }) async {
//     return await _httpService.postRequestFormData(ApiUrls.forgotPasswordSendOtp,
//         data: {
//           'email': emailOrPhone,
//           'verification_method': verificationMethod,
//         },
//         token: '');
//   }

//   // Forgot Password Verify password
//   Future<ApiBaseDataModel> forgotPasswordVerifyOtp({
//     required String emailOrPhone,
//     required String otp,
//   }) async {
//     return await _httpService.postRequestFormData(
//         ApiUrls.forgotPasswordVerifyOtp,
//         data: {
//           'email': emailOrPhone,
//           'otp': otp,
//         },
//         token: '');
//   }

//   // Change Password

//   Future<ApiBaseDataModel> forgotPasswordChangePassword({
//     required String emailOrPhone,
//     required String password,
//     required String passwordConfirmation,
//   }) async {
//     return await _httpService.postRequestFormData(
//         ApiUrls.forgotPasswordChangePassword,
//         data: {
//           'email': emailOrPhone,
//           'password_confirmation': passwordConfirmation,
//           'password': password,
//         },
//         token: '');
//   }
}
