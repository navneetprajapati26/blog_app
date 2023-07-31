import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../util/api_service.dart';
import '../model/register_user.dart';

class AuthProvider with ChangeNotifier {
  final apiService =
      ApiService(baseUrl: 'https://blog-app-backend-7sem.onrender.com/');

  bool isLoading = false;

  Future<void> registerUser(RegisterUser user, BuildContext context) async {
    print("-------------------------------------");
    isLoading = true;
    notifyListeners();

    apiService.post('api/user/signup', user.toJson()).then((data) {
      isLoading = false;
      print(data['message']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );

      notifyListeners();
    }).catchError((error) {
      print('Error: $error');
    });
  }

  Future<void> getAllUsers(BuildContext context) async {
    RegisterUser newUser = RegisterUser(
        name: 'John Doe', email: 'john@example.com', password: 'password123');

    apiService.post('api/user/signup', newUser.toJson()).then((data) {
      print(data['message']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
      notifyListeners();
    }).catchError((error) {
      print('Error: $error');
    });
  }
}
