import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/classes/timer.dart';
import 'package:aquaria/classes/user.dart';
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
    currentUser =
        User(request.id, request.username, request.email, request.password);

    return request;
  }

  return 400;
}

Future<dynamic> timerFinished(minutes) async {
  Timer timer = Timer(null, minutes, 1, null);
  // Timer timer = Timer(null, minutes, currentUser!.id, null);
  dynamic request = await createTimer(timer);

  if (request is Timer) {
    return Timer(request.id, request.minutes, request.userId, request.fishId);
  }

  return 400;
}

Future<dynamic> fishcollection(name,description,image) async{
  Fish fish = Fish(null, name, description, image);
  
}
