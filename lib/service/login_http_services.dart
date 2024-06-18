import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginHttpServices {
  Future<Map<String, dynamic>> sign(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAqnk0IfCtaPDsBWxz873X1MNkblbBzSBM");
    var response = await http.post(url,
        body: jsonEncode(
            {"email": email, "password": password, "returnSecureToken": true}));
    if (response.statusCode != 200) {
      return {"check": false};
    }
    var data = jsonDecode(response.body);
    bool? aaa = false;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    aaa = await sharedPreferences.setBool("check", true);
    print("$aaa aaa");

    return {"check": true, "localId": data["localId"]};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAqnk0IfCtaPDsBWxz873X1MNkblbBzSBM");
    var response = await http.post(url,
        body: jsonEncode(
            {"email": email, "password": password, "returnSecureToken": true}));
    if (response.statusCode != 200) {
      print("error");
      return {"check": false};
    }
    var data = jsonDecode(response.body);
    bool? aaa = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    aaa = await sharedPreferences.setBool("check", true);
    print("$aaa aaa");
    return {"check": true, "localId": data["localId"]};
  }
}
