import 'dart:async';
import 'dart:convert';

import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/classes/task.dart';
import 'package:aquaria/classes/user.dart';
import 'package:aquaria/functions/functions.dart';
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

Future<List<dynamic>?> getFish(timer) async {
  final response = await http.post(
    Uri.parse("$uri/get-fish"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(timer),
  );

  print(jsonEncode(timer));
  print(response.statusCode);
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);

    List<dynamic> fishList = body.map((item) => Fish.fromJson(item)).toList();
    print(response.body);
    return fishList;
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
    dynamic body = jsonDecode(response.body);

    return body;
  }

  return null;
}

Future<Task?> createTask(task) async {
  final response = await http.post(
    Uri.parse("$uri/add-task"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(task),
  );

  if (response.statusCode == 200) {
    return Task.fromJson(jsonDecode(response.body));
  }

  return null;
}

Future<int?> renewTask(task) async {
  final response = await http.post(
    Uri.parse("$uri/update-task"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(task),
  );

  if (response.statusCode == 200) {
    print("update success");

    return jsonDecode(response.body)["changed_row"];
  }

  return null;
}

Future<dynamic> removeTask(task) async {
  final response = await http.post(
    Uri.parse("$uri/delete-task"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(task),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)["isDeleted"];
  }

  return null;
}

Future<List<Task>?> viewTasks(user) async {
  final response = await http.post(
    Uri.parse("$uri/show-task"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(user),
  );

  if (response.statusCode == 200) {
    print("berhasil");

    // final Map<String, dynamic> jsonMap = jsonDecode(response.body);
    // List<Task> taskList = [];

    // jsonMap.forEach((key, value) {
    //   taskList.add(Task.fromJson(value));
    // });

    List<dynamic> body = jsonDecode(response.body);

    // print(body);

    List<Task> taskList = (body).map((itemWord) => Task.fromJson(itemWord)).toList();

    // print(taskList);

    return taskList;
  }

  return null;
}

Future<bool?> markTask(task) async {
  final response = await http.post(
    Uri.parse("$uri/check-task"),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode(task),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)["isChecked"];
  }

  return null;
}

Future<User?> renewName(user) async {
  final response = await http.post(
    Uri.parse("$uri/change-email"),
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

Future<User?> renewPassword(user) async {
  final response = await http.post(
    Uri.parse("$uri/change-password"),
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
