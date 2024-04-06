import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  final String? id;
  final String fullname;
  final String cardnumber;
  final String cvv;
  final String expdate;

  const UserModal(
      {this.id,
      required this.fullname,
      required this.cardnumber,
      required this.cvv,
      required this.expdate});

  toJson() {
    return {
      "FullName": fullname,
      "CardNumber": cardnumber,
      "CVV": cvv,
      "ExpireDate": expdate,
    };
  }

  factory UserModal.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModal(
        fullname: data["FullName"],
        cardnumber: data["CardNumber"],
        cvv: data["CVV"],
        expdate: data["ExpireDate"]);
  }
}
