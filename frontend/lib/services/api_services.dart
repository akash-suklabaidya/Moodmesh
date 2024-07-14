import 'package:frontend/controller/user_signup_controller.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.1.4:8080";
  final SignupController signupController = SignupController();

  Future<http.Response> getData() async {
    String? token = await signupController.getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/data'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
