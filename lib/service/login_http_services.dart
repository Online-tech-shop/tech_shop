import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginHttpServices {
  final String _apiKey = "AIzaSyAqnk0IfCtaPDsBWxz873X1MNkblbBzSBM";
  final String _signUpUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
  final String _signInUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";

  Future<Map<String, dynamic>> sign(String email, String password) async {
    return await _authenticate(email, password, _signUpUrl);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _authenticate(email, password, _signInUrl);
  }

  Future<Map<String, dynamic>> _authenticate(String email, String password, String url) async {
    Uri uri = Uri.parse(url + _apiKey);
    var response = await http.post(
      uri,
      body: jsonEncode({"email": email, "password": password, "returnSecureToken": true}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      return {"check": false, "message": jsonDecode(response.body)["error"]["message"]};
    }

    var data = jsonDecode(response.body);
    return {"check": true, "localId": data["localId"]};
  }
}
