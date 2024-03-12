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
  if (globals.isTimerStarted == false) {
    return null;
  } else {
    globals.isTimerStarted = false;
    await Future.delayed(const Duration(seconds: 5));
    Timers timer = Timers(null, minutes, currentUser!.id, null, null);
    dynamic request = await createTimer(timer);

    if (request is Fish) {
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
  }
  return null;
}

Future<dynamic> fishcollection(name, description, image) async {
  Fish fish = Fish(null, name, description, image);
}

Future<List<Task>?> showAllTask() async {
  List<Task>? request = await viewTasks(currentUser);

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

Future<List<List<dynamic>?>> getProgressData() async {
  dynamic request = await getTimerByUser(currentUser!.id);

  bool isWeeklyEmpty = false;
  bool isMonthlyEmpty = false;
  bool isYearlyEmpty = false;
  bool isTaskEmpty = false;

  if (request == null) {
    return List.empty();
  }

  List<List<dynamic>> allProgressList = [];

  List<dynamic> weeklyProgressList = [
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
  List<dynamic> monthlyProgressList = [];
  List<dynamic> yearlyProgressList = [];

  List<dynamic> taskUrgencyList = [
    {
      "color": "0xFF0463CA",
      "chart": 0,
    },
    {
      "color": "0xFF2A99E6",
      "chart": 0,
    },
    {
      "color": "0xFF09B1EC",
      "chart": 0,
    },
    {
      "color": "0xFF82CEF7",
      "chart": 0,
    },
    {
      "color": "0xFFB0D6F5",
      "chart": 0,
    },
  ];

  var daysInMonth = request['days_in_month']['days_in_month'];

  if (request['timers_by_week'][0].toString() == "Empty") {
    isWeeklyEmpty = true;
  } else if (request['timers_by_month'][0].toString() == "Empty") {
    isMonthlyEmpty = true;
  } else if (request['timers_by_year'][0].toString() == "Empty") {
    isYearlyEmpty = true;
  } else if (request['task_total'] == 0) {
    isTaskEmpty = true;
  }

  if (!isWeeklyEmpty) {
    for (var item in request['timers_by_week']) {
      if (item['dayname'] == "Monday") {
        weeklyProgressList[0]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Tuesday") {
        weeklyProgressList[1]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Wednesday") {
        weeklyProgressList[2]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Thursday") {
        weeklyProgressList[3]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Friday") {
        weeklyProgressList[4]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Saturday") {
        weeklyProgressList[5]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Sunday") {
        weeklyProgressList[6]['totalMinutes'] += int.parse(item['daily_focus_time']);
      }
    }
  }

  if (!isMonthlyEmpty) {
    for (var i = 0; i < daysInMonth; i++) {
      monthlyProgressList.add({'day': i + 1, 'daily_total_minutes': 0});
    }

    for (var item in request['timers_by_month']) {
      monthlyProgressList[item['date'] - 1]['daily_total_minutes'] = int.parse(item['monthly_focus_time']);
    }
  }

  if (!isYearlyEmpty) {
    for (var i = 0; i < 12; i++) {
      yearlyProgressList.add({'month': i + 1, 'monthly_total_minutes': 0});
    }

    for (var item in request['timers_by_year']) {
      yearlyProgressList[item['month'] - 1]['monthly_total_minutes'] = int.parse(item['yearly_focus_time']);
    }
  }

  if (!isTaskEmpty) {
    var totalTask = request['total_task'];

    for (var item in request['task_urgency_list']) {
      if (item['urgency'] == "Critical") {
        taskUrgencyList[0]['chart'] = (item['urgencyCount'] / totalTask) * 100;
      }
      if (item['urgency'] == "High") {
        taskUrgencyList[1]['chart'] = (item['urgencyCount'] / totalTask) * 100;
      }
      if (item['urgency'] == "Medium") {
        taskUrgencyList[2]['chart'] = (item['urgencyCount'] / totalTask) * 100;
      }
      if (item['urgency'] == "Low") {
        taskUrgencyList[3]['chart'] = (item['urgencyCount'] / totalTask) * 100;
      }
      if (item['urgency'] == "Very Low") {
        taskUrgencyList[4]['chart'] = (item['urgencyCount'] / totalTask) * 100;
      }
    }
  }

  List<dynamic> taskCountList = [
    {
      "completed_task_count": request['completed_task_count'],
    },
    {
      "pending_task_count": request['pending_task_count'],
    },
  ];

  print("test: ${request['total_monthly_time'][0]['total_monthly_time']}");

  List<dynamic> totalTimeList = [
    {
      "total_weekly_time": request['total_weekly_time'][0]['total_weekly_time'],
    },
    {
      "total_monthly_time": request['total_monthly_time'][0]['total_monthly_time'],
    },
    {
      "total_yearly_time": request['total_yearly_time'][0]['total_yearly_time'],
    },
  ];

  allProgressList.add(request['recent_catch']);
  allProgressList.add(weeklyProgressList);
  allProgressList.add(monthlyProgressList);
  allProgressList.add(yearlyProgressList);
  allProgressList.add(taskUrgencyList);
  allProgressList.add(taskCountList);
  allProgressList.add(totalTimeList);

  print("APL: $allProgressList");

  return allProgressList;
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
