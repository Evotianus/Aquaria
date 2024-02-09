import 'dart:async';
import 'dart:convert';

import 'package:aquaria/classes/timer.dart';
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

Future<Timer?> createTimer(timer) async {
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
    return Timer.fromJson(jsonDecode(response.body));
  }

  return null;
}
