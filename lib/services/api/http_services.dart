import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ez_navy_app/model/api_base_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final timeoutDuration = const Duration(seconds: 90);

  Future<ApiBaseDataModel> apiGetRequest(String apiUrls) async {
    http.Client client = http.Client();

    try {
      var response =
          await client.get(Uri.parse(apiUrls)).timeout(timeoutDuration);
      if (response.statusCode == 200) {
        return ApiBaseDataModel(status: true, data: jsonDecode(response.body));
      } else {
        return ApiBaseDataModel(
            status: false, errorMessage: 'Something bad happend');
      }
    } on TimeoutException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'The request time out');
    } on SocketException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'No internet connection');
    } catch (e) {
      return ApiBaseDataModel(status: false, errorMessage: e.toString());
    } finally {
      client.close();
    }
  }

  Future<ApiBaseDataModel> apiPostRequest(
      String apiUrl, Map<String, dynamic> bodyData) async {
    http.Client client = http.Client();

    try {
      final response = await client
          .post(Uri.parse(apiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(bodyData))
          .timeout(timeoutDuration);

      if (response.statusCode == 201) {
        return ApiBaseDataModel(status: true, data: jsonDecode(response.body));
      } else {
        return ApiBaseDataModel(
            status: false, errorMessage: 'an error happend');
      }
    } on TimeoutException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'Server request timeout');
    } on SocketException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'Internet connection faild');
    } catch (e) {
      return ApiBaseDataModel(status: false, errorMessage: e.toString());
    } finally {
      client.close();
    }
  }

  Future<ApiBaseDataModel> apiPutRequest(
      String apiUrl, Map<String, dynamic> bodyData) async {
    http.Client client = http.Client();

    try {
      final response = await client
          .put(Uri.parse(apiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(bodyData))
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        return ApiBaseDataModel(status: true, data: jsonDecode(response.body));
      } else {
        return ApiBaseDataModel(
            status: false, errorMessage: 'an error happend');
      }
    } on TimeoutException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'Server request timeout');
    } on SocketException {
      return ApiBaseDataModel(
          status: false, errorMessage: 'Internet connection faild');
    } catch (e) {
      return ApiBaseDataModel(status: false, errorMessage: e.toString());
    } finally {
      client.close();
    }
  }
}
