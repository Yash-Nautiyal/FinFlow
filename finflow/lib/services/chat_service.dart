import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> sendChatQuery(String userId, String query) async {
  final url = Uri.parse('http://192.168.29.167:8000/chat'); // Replace with your API URL

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'query': query}),
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Handle error responses
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Handle network or other errors
    print('Exception: $e');
    return null;
  }
}
