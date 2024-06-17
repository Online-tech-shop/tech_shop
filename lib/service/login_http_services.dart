import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tech_shop/models/user_model.dart';

class LoginHttpServices {
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDbklOtGFEhnWwSkCGDCZ3IgwyB1wMw4mk");
    var response = await http.post(
      url,
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );
    if (response.statusCode != 200) {
      return {"check": false};
    }
    var data = jsonDecode(response.body);
    try {
      getUser(data['localId']);
    } catch (e) {
      rethrow;
    }
    return {"check": true, "localId": data["localId"]};
  }

  Future<User> addUser(
    String name,
    String surname,
    String email,
    String gender,
    String localId,
    String bornData,
  ) async {
    final Map<String, dynamic> userData = {
      'born-data': bornData,
      'email': email,
      'gender': gender,
      'local-id': localId,
      'name': name,
      'sur-name': surname,
    };
    final response = await http.post(
      Uri.parse('https://to-do-f5021-default-rtdb.firebaseio.com/users.json'),
      body: jsonEncode(userData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
    userData['id'] = jsonDecode(response.body)['name'];
    return User.fromJson(userData);
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDbklOtGFEhnWwSkCGDCZ3IgwyB1wMw4mk',
    );

    try {
      final http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        throw Exception(data['error']['message']);
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser(String localId) async {
    final Uri url =
        Uri.parse('https://to-do-f5021-default-rtdb.firebaseio.com/users.json');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user data');
    }

    final Map<String, dynamic> userDataMap = jsonDecode(response.body);

    var userData;
    userDataMap.forEach((key, value) {
      if (value['local-id'] == localId) {
        userData = value;
        userData['id'] = key;
      }
    });

    if (userData == null) {
      throw Exception('User with localId $localId not found');
    }

    return User.fromJson(userData);
  }
}
//{
//   "-O-a1xor6jyGdAUR5Hds": {
//     "born-data": "yesterday",
//     "email": "email",
//     "gender": 1,
//     "local-id": "",
//     "name": "Gishmatali",
//     "sur-name": "userjon"
//   }
// }
