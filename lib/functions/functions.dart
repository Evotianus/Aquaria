import 'package:aquaria/services/http_service.dart';

import '../classes/user.dart';

Future<int> registerUser(username, email, password, confirmPassword) async {
  if (password != confirmPassword) {
    return 400;
  }

  User user = User(username, email, password);
  dynamic request = await createUser(user);

  if (request == 200) {
    return 200;
  }

  return 500;
}

Future<dynamic> loginUser(username, password) async {
  User user = User(username, "", password);
  dynamic request = await verifyUser(user);

  if (request is User) {
    return request;
  }

  return 400;
}
