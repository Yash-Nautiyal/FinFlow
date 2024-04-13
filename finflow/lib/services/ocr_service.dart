import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OCRService {
  static Future<Map<String, dynamic>?> processReceipt(File imageFile) async {
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
        // Extract relevant data from OCR results (assuming it follows the expected structure)
        final merchantName = ocrData['receipts'][0]['merchant_name'];
        final currency = ocrData['receipts'][0]['currency'];
        final total = ocrData['receipts'][0]['total'];
        final items = ocrData['receipts'][0]['items']; // Extract items

// Modify the return statement to include all extracted fields
        return {
          'user_id': userId,
          'ocr_data': {
            'Merchant_Name': merchantName,
            'Currency': currency,
            'Total': total,
            // Include other extracted fields
            'Subtotal': ocrData['receipts'][0]['subtotal'],
            'Tax': ocrData['receipts'][0]['tax'],
            'Tip': ocrData['receipts'][0]['tip'],
            'Payment_Method': ocrData['receipts'][0]['payment_method'],
            'Date': ocrData['receipts'][0]['date'],
            'Time': ocrData['receipts'][0]['time'],
            'Items': items,
            // Add more fields as needed
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

  Future<void> sendDataToPythonAPI(Map<String, dynamic> data) async {
    final url = Uri.parse(
        'http://your_python_api_endpoint'); // Replace with your API URL

    final response = await http.post(
      url,
      body:
          jsonEncode(data), // Send the OCR data returned by the service method
    );

    if (response.statusCode == 200) {
      print('Data sent to Python API successfully');
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }
}

// Future<Map<String, dynamic>?> processReceipt(File imageFile) async {
//   print('object');

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final User? user = auth.currentUser;

//   if (user != null) {
//     final userId = user.uid;
//     var url = 'https://ocr2.asprise.com/api/v1/receipt';

//     // Create a multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(url));

//     // Add form fields
//     request.fields['api_key'] = 'TEST';
//     request.fields['recognizer'] = 'auto';
//     request.fields['ref_no'] = 'oct_dart_123';

//     // Add the image file
//     request.files.add(await http.MultipartFile.fromPath(
//       'file',
//       imageFile.path,
//       filename: imageFile.path.split('/').last,
//     ));
//     print('object2');

//     // Send the request
//     var response = await http.Response.fromStream(await request.send());

//     // Check if the request was successful
//     if (response.statusCode == 200) {
//       print('object3');

//       // Parse the response
//       var ocrData = json.decode(response.body);

//       // Extract relevant data from OCR results (assuming it follows the expected structure)
//       // Extract relevant data from OCR results (assuming it follows the expected structure)
//       final merchantName = ocrData['receipts'][0]['merchant_name'];
//       final currency = ocrData['receipts'][0]['currency'];
//       final total = ocrData['receipts'][0]['total'];
//       final items = ocrData['receipts'][0]['items']; // Extract items

// // Modify the return statement to include all extracted fields
//       return {
//         'user_id': userId,
//         'ocr_data': {
//           'Merchant_Name': merchantName,
//           'Currency': currency,
//           'Total': total,
//           // Include other extracted fields
//           'Subtotal': ocrData['receipts'][0]['subtotal'],
//           'Tax': ocrData['receipts'][0]['tax'],
//           'Tip': ocrData['receipts'][0]['tip'],
//           'Payment_Method': ocrData['receipts'][0]['payment_method'],
//           'Date': ocrData['receipts'][0]['date'],
//           'Time': ocrData['receipts'][0]['time'],
//           'Items': items,
//           // Add more fields as needed
//         },
//       };
//     } else {
//       print('Error: ${response.statusCode}');
//       return null;
//     }
//   } else {
//     print('No user signed in');
//     return null;
//   }
// }
//     // Save the response to a JSON file
//     //var jsonString = json.encode(jsonResponse);
//     //await File('response2.json').writeAsString(jsonString);

//     // Extract items from the response
//     var items = jsonResponse['receipts'][0]['items'];
//     for (var item in items) {
//       print('${item['description']} : ${item['amount']}');
//     }
//     print('Total: ${jsonResponse['receipts'][0]['total']}');
//   } else {
//     print('Error: ${response.statusCode}');
//   }
// }
