import 'dart:async';
import 'dart:convert';

import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/classes/user.dart';
import 'package:http/http.dart' as http;

String? uri = "http://10.0.2.2:8000/api";

Future<User?> createUser(user) async {
  final response = await http.post(
    Uri.parse("$uri/create-user"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(user),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }

  return null;
}

Future<User?> verifyUser(user) async {
  final response = await http.post(
    Uri.parse("$uri/verify-user"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(user),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }

  return null;
}

Future<Fish?> createTimer(timer) async {
  final response = await http.post(
    Uri.parse("$uri/create-timer"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(timer),
  );

  print(jsonEncode(timer));

  if (response.statusCode == 200) {
    return Fish.fromJson(jsonDecode(response.body));
  }

  return null;
}

Future<Fish?> getFish(fish) async {
  final response = await http.get(
    Uri.parse("$uri/verify-user"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  if (response.statusCode == 200) {
    return Fish.fromJson(jsonDecode(response.body));
  }

  return null;
}

Future<dynamic> getTimerByUser(userId) async {
  final response = await http.post(
    Uri.parse("$uri/get-timer-by-user"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode({"userId": userId}),
  );

  print(jsonEncode({"userId": userId}));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);

    // List<dynamic> timerList =
    //     body.map((dynamic item) => Timer.fromJson(item)).toList();

    return body;
  }

  return null;
}
