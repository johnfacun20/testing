import 'dart:convert';

import '../model/api_response.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../variables.dart';

Future<ApiResponse> login(String email, String password) async {

  ApiResponse apiResponse = ApiResponse();

  try {

    final response = await http.post(
      Uri.parse('$ipaddress/login'),
      headers: {'Accept':'application/json'},
      body: {'email':email, 'password':password}
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = 'Something went wrong.';
        break;
    }

  } catch(e){
    apiResponse.error = 'Something went wrong.';
  }

  return apiResponse;
}

Future<ApiResponse> register(String name, String email, String password) async {

  ApiResponse apiResponse = ApiResponse();

  try{

    final response = await http.post(
      Uri.parse('$ipaddress/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'name':name,
        'email':email,
        'password':password,
        'password_confirmation':password
      }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['response'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "Something went wrong.";
        break;
    }

  } catch(e){
    apiResponse.error = "Something went wrong.";
  }

  return apiResponse;

}

Future<ApiResponse> saveUser(String name, String email, String age, String account_type, String password, String? token) async {

  ApiResponse apiResponse = ApiResponse();

  try{

    final response = await http.post(
        Uri.parse('$ipaddress/users'),
        headers: {
          'Accept': 'application/json',
          'Authorization':'Bearer ${token}'
        },
        body: {
          'name':name,
          'email':email,
          'age':age,
          'account_type':account_type,
          'password':password
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['response'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "Something went wrong.";
        break;
    }

  } catch(e){
    apiResponse.error = "Something went wrong"+e.toString();
  }

  return apiResponse;

}

Future<ApiResponse> deleteUser(int userID) async {

  ApiResponse apiResponse = ApiResponse();

  try{

    final response = await http.delete(
        Uri.parse('$ipaddress/users/${userID.toString()}'),
        headers: {'Accept': 'application/json'},
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['response'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "Something went wrong.";
        break;
    }

  } catch(e){
    apiResponse.error = "Something went wrong"+e.toString();
  }

  return apiResponse;

}

Future<ApiResponse> getAllUsers(String? token) async {

  ApiResponse apiResponse = ApiResponse();

  try {

    final response = await http.get(
      Uri.parse('$ipaddress/users'),
      headers: {
        'Accept': 'application/json',
        'Authorization':'Bearer ${token}'
      }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['users'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = 'Something went wrong.';
        break;
    }

  } catch(e){
    apiResponse.error = 'Something went wrong.';
  }

  return apiResponse;
}

Future<ApiResponse> getUser(String? userID) async {

  ApiResponse apiResponse = ApiResponse();

  try {

    final response = await http.get(
        Uri.parse('$ipaddress/users/${userID}'),
        headers: {
          'Accept': 'application/json'
        }
    );

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['user'];
        print(jsonDecode(response.body)['user']);
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = 'Something went wrong.';
        break;
    }

  } catch(e){
    apiResponse.error = 'Something went wrong.';
  }

  return apiResponse;
}