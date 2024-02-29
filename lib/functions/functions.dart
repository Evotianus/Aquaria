import 'dart:async';

import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/classes/task.dart';
import 'package:aquaria/classes/timers.dart';
import 'package:aquaria/classes/user.dart';
import 'package:aquaria/services/http_service.dart';
import 'package:async/async.dart';

import '../services/globals.dart' as globals;

User? currentUser;
AsyncMemoizer<Fish?> _memoizer = AsyncMemoizer();

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

Future<Fish?> fishStrike(minutes) async {
  Fish? request = await timerFinished(minutes);

  return request;
}

Future<Fish?> timerFinished(int minutes) async {
  print("wi");
  if (globals.isTimerStarted == false) {
    return null;
  } else {
    globals.isTimerStarted = false;
    print("minit neh: $minutes");
    // Timer(Duration(minutes: minutes - 1, seconds: 55), () async {
    await Future.delayed(const Duration(seconds: 5));
    // Timer(const Duration(seconds: 5), () async {
    Timers timer = Timers(null, minutes, currentUser!.id, null, null);
    dynamic request = await createTimer(timer);

    if (request is Fish) {
      print("masuk if");

      globals.fishCaught = Fish(
        request.id,
        request.name,
        request.description,
        request.image,
      );
      return Fish(
        request.id,
        request.name,
        request.description,
        request.image,
      );
    }
    print("luar if");
  }
  return null;
}

Future<List<Fish>?> fishcollection() async {
  Timer timer = Timer(null, null, 1, 4);
  List<Fish>? request = await getFish(timer);

  // print(request);
  if (request is List<Fish>) {
    print(request[0]);
    return request;
  }
  return null;
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

Future<List<dynamic>> getProgressData() async {
  dynamic request = await getTimerByUser(currentUser!.id);
  print("request $request");

  if (request is List<dynamic>) {
    // print("asdf");
    List<dynamic> progressList = [
      {
        "totalMinutes": 0,
        "dayName": "Monday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Tuesday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Wednesday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Thursday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Friday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Saturday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Sunday",
      },
    ];
    print("mantul bro $request");

    for (var item in request) {
      print("item: $item");
      // print("asdfff");
      // print(progressList[0]['totalMinutes'].runtimeType);
      // print(item['daily_focus_time'].runtimeType);
      // print("${progressList[4]['totalMinutes'].runtimeType} - ${int.parse(item['daily_focus_time']).runtimeType}");
      // if (item['dayname'] == "Monday") {
      //   progressList[0]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Tuesday") {
      //   progressList[1]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Wednesday") {
      //   progressList[2]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Thursday") {
      //   // print("woi");
      //   progressList[3]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Friday") {
      //   progressList[4]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Saturday") {
      //   progressList[5]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // } else if (item['dayname'] == "Sunday") {
      //   progressList[6]['totalMinutes'] += int.parse(item['daily_focus_time']);
      // }
    }
    print("huhhhh");
    return progressList;
  }

  return [];
}

Future<dynamic> changeName(newName) async {
  User user = User(currentUser!.id, newName, currentUser!.email, currentUser!.password);
  dynamic request = await renewName(user);

  if (request is User) {
    currentUser = User(request.id, request.username, request.email, request.password);

    print(currentUser!.username);

    return 200;
  }

  return 400;
}

Future<dynamic> changeEmail(newEmail) async {
  User user = User(currentUser!.id, currentUser!.username, newEmail, currentUser!.password);
  dynamic request = await renewName(user);

  if (request is User) {
    currentUser = User(request.id, request.username, request.email, request.password);

    print(currentUser!.email);

    return 200;
  }

  return 400;
}

Future<dynamic> changePassword(newPassword) async {
  User user = User(currentUser!.id, currentUser!.username, currentUser!.email, newPassword);
  dynamic request = await renewPassword(user);

  if (request is User) {
    currentUser = User(request.id, request.username, request.email, request.password);

    print(currentUser!.password);

    return 200;
  }

  return 400;
}
