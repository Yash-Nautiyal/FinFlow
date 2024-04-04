import 'package:finflow/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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
                    image: AssetImage('images/Card.jpg'), fit: BoxFit.cover)),
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
                    glassmorphismConfig: _getGlassmorphismConfig(),
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
                    backgroundImage: 'images/Card.jpg',
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
                          /* GestureDetector(
                            onTap: _onValidate,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    AppColors.colorB58D67,
                                    AppColors.colorB58D67,
                                    AppColors.colorE5D1B2,
                                    AppColors.colorF9EED2,
                                    AppColors.colorEFEFED,
                                    AppColors.colorF9EED2,
                                    AppColors.colorB58D67,
                                  ],
                                  begin: Alignment(-1, -4),
                                  end: Alignment(1, 4),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: isvalid
                                  ? Icon(
                                      FontAwesomeIcons.check,
                                      color: green,
                                    )
                                  : const Text(
                                      'Validate',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'halter',
                                        fontSize: 14,
                                        package: 'flutter_credit_card',
                                      ),
                                    ),
                            ),
                          ), */
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
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

  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return isLightTheme
        ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
        : Glassmorphism.defaultConfig();
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
