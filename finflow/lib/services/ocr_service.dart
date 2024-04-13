import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OCRService {
  static Future<Map<String, dynamic>?> performOCR(File imageFile) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final userId = user.uid;

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://ocr.asprise.com/api/v1/receipt'));
      request.fields['api_key'] = 'TEST'; // Replace with your actual API key
      request.fields['recognizer'] = 'auto';
      request.fields['ref_no'] = 'oct_python_123'; // Optional reference number
      request.files.add(http.MultipartFile(
          'file', imageFile.openRead(), imageFile.lengthSync(),
          filename: imageFile.path, contentType: MediaType('image', 'jpeg')));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        final ocrData = jsonDecode(responseData);
        // Extract relevant data from OCR results (assuming it follows the expected structure)
        final merchantName = ocrData['merchant_name'];
        final currency = ocrData['currency'];
        final total = ocrData['total'];
        // Extract other relevant fields

        return {
          'user_id': userId,
          'ocr_data': {
            'Merchant_Name': merchantName,
            'Currency': currency,
            'Total': total,
            // Include other extracted fields
          },
        };
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } else {
      print('No user signed in');
      return null;
    }
  }
}

Future<Map<String, dynamic>?> processReceipt(File imageFile) async {
  print('object');

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user != null) {
    final userId = user.uid;
    var url = 'https://ocr2.asprise.com/api/v1/receipt';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add form fields
    request.fields['api_key'] = 'TEST';
    request.fields['recognizer'] = 'auto';
    request.fields['ref_no'] = 'oct_dart_123';

    // Add the image file
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      filename: imageFile.path.split('/').last,
    ));
    print('object2');

    // Send the request
    var response = await http.Response.fromStream(await request.send());

    // Check if the request was successful
    if (response.statusCode == 200) {
      print('object3');

      // Parse the response
      var ocrData = json.decode(response.body);

      // Extract relevant data from OCR results (assuming it follows the expected structure)
      final merchantName = ocrData['merchant_name'];
      final currency = ocrData['currency'];
      final total = ocrData['total'];
      // Extract other relevant fields

      return {
        'user_id': userId,
        'ocr_data': {
          'Merchant_Name': merchantName,
          'Currency': currency,
          'Total': total,
          // Include other extracted fields
        },
      };
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } else {
    print('No user signed in');
    return null;
  }
}
    // Save the response to a JSON file
    //var jsonString = json.encode(jsonResponse);
    //await File('response2.json').writeAsString(jsonString);

    // Extract items from the response

//----------------------------------------------------------------------------------------------------------------------------------------------

/*     var items = jsonResponse['receipts'][0]['items'];
    for (var item in items) {
      print('${item['description']} : ${item['amount']}');
    }
    print('Total: ${jsonResponse['receipts'][0]['total']}');
  } else {
    print('Error: ${response.statusCode}');
  }
}
 */