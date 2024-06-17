import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginHttpServices {
  Future<Map<String, dynamic>> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAqnk0IfCtaPDsBWxz873X1MNkblbBzSBM");
    var response = await http.post(url,
        body: jsonEncode(
            {"email": email, "password": password, "returnSecureToken": true}));
    if (response.statusCode != 200) {
      return {"check": false};
    }
    var data = jsonDecode(response.body);
    return {"check": true, "localId": data["localId"]};
  }
}
