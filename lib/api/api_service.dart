import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/model/user_detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>?> getUser() async {
    await dotenv.load(fileName: '.env');
    String baseUrl = dotenv.env["API_URL"]!;
    String token = dotenv.env["TOKEN_API"]!;
    final response = await http.get(
        Uri.parse("$baseUrl/search/users?q=sandra"),
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserDetail?> getDetail(user) async {
    await dotenv.load(fileName: '.env');
    String baseUrl = dotenv.env["API_URL"]!;
    String token = dotenv.env["TOKEN_API"]!;
    final response = await http.get(
        Uri.parse("$baseUrl/users/$user"),
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return userDetailFromJson(response.body);
    } else {
      return null;
    }
  }
}