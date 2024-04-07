import 'package:finflow/utils/firebase/controllers/Add_controller.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  bool isvalid = false;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/card/Card.jpg'),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Add New Card",
                      style: textTheme.displayMedium!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  CreditCardWidget(
                    enableFloatingCard: useFloatingAnimation,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    frontCardBorder: useGlassMorphism
                        ? null
                        : Border.all(color: Colors.grey),
                    backCardBorder: useGlassMorphism
                        ? null
                        : Border.all(color: Colors.grey),
                    showBackView: isCvvFocused,
                    obscureCardNumber: false,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: isLightTheme
                        ? AppColors.cardBgLightColor
                        : AppColors.cardBgColor,
                    backgroundImage: 'images/card/Card.jpg',
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          'images/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CreditCardForm(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            inputConfiguration: InputConfiguration(
                              cardNumberDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: purple),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                filled: true,
                                fillColor: grey,
                                labelText: 'Card Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                              ),
                              expiryDateDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: purple),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                filled: true,
                                fillColor: grey,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                              ),
                              cvvCodeDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: purple),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                filled: true,
                                fillColor: grey,
                                labelText: 'CVV',
                                hintText: 'XXX',
                              ),
                              cardHolderDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: white),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: purple),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                filled: true,
                                fillColor: grey,
                                labelText: 'Card Holder',
                              ),
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              final user = UserModal(
                                  fullname: cardHolderName.toString().trim(),
                                  cardnumber: cardNumber.toString().trim(),
                                  cvv: cvvCode.toString().trim(),
                                  expdate: expiryDate.toString().trim());

                              final add = Get.put(AddController());
                              add.addDetails(user);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: purple,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: Text('Save',
                                  style: textTheme.displayMedium!.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isvalid = true;
      });
    } else {
      setState(() {
        isvalid = false;
      });
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

class AppColors {
  AppColors._();

  static const Color cardBgColor = Color(0xff363636);
  static const Color cardBgLightColor = Color(0xff999999);
  static const Color colorB58D67 = Color(0xffB58D67);
  static const Color colorE5D1B2 = Color(0xffE5D1B2);
  static const Color colorF9EED2 = Color(0xffF9EED2);
  static const Color colorEFEFED = Color(0xffEFEFED);
}
