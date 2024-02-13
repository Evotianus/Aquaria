import 'package:aquaria/classes/fish.dart';
import 'dart:convert';

import 'package:aquaria/classes/timer.dart';
import 'package:aquaria/classes/user.dart';
import 'package:aquaria/classes/task.dart';
import 'package:aquaria/services/http_service.dart';

User? currentUser;

Future<int> registerUser(username, email, password, confirmPassword) async {
  if (password != confirmPassword) {
    return 400;
  }

  User user = User(null, username, email, password);
  dynamic request = await createUser(user);

  if (request == 200) {
    return 200;
  }

  return 500;
}

Future<dynamic> loginUser(username, password) async {
  User user = User(null, username, null, password);
  dynamic request = await verifyUser(user);

  if (request is User) {
    currentUser = User(request.id, request.username, request.email, request.password);

    print(currentUser!.id);

    return request;
  }

  return 400;
}

Future<dynamic> timerFinished(minutes) async {
  Timer timer = Timer(null, minutes, currentUser!.id, null);
  dynamic request = await createTimer(timer);

  if (request is Timer) {
    return Timer(request.id, request.minutes, request.userId, request.fishId);
  }

  return 400;
}

Future<dynamic> fishcollection(name, description, image) async {
  Fish fish = Fish(null, name, description, image);
}

Future<List<Task>?> showAllTask() async {
  List<Task>? request = await viewTasks(currentUser);

  // print(request);

  if (request is List<Task>) {
    print("berhasil 2");

    return request;
  }

  print("gagal 2");

  return null;
}

Future<dynamic> addTask(title, urgency, due) async {
  Task task = Task(null, currentUser!.id, title, urgency, due, 0);

  dynamic request = await createTask(task);

  if (request is Task) {
    print("berhasil add task");
    return 200;
  }

  return 400;
}

Future<dynamic> updateTask(oldTask, title, urgency, due) async {
  Task task = Task(oldTask.id, currentUser!.id, title, urgency, due, 0);

  dynamic request = await renewTask(task);

  if (request > 0) {
    print("berhasil update task");
    return 200;
  }

  return 400;
}

Future<dynamic> deleteTask(oldTask) async {
  Task task = Task(oldTask.id, currentUser!.id, oldTask.title, oldTask.urgency, oldTask.due, oldTask.isFinished);

  dynamic request = await removeTask(task);

  if (request > 0) {
    print("berhasil delete task");
    return 200;
  }

  return 400;
}

Future<dynamic> checkTask(task) async {
  dynamic request = await markTask(task);
  try {
    print("berhasil check task");
    return 200;
  } on Exception catch (e) {
    return 400;
  }
}
