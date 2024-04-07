import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Amount extends StatefulWidget {
  final String name;
  final String phone;
  const Amount({super.key, required this.name, required this.phone});

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenheights = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15)
              .copyWith(bottom: 20),
          child: Column(
            children: [
              Text(
                'Enter Amount',
                style: textTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'To: ',
                        style: textTheme.displaySmall!.copyWith(fontSize: 15),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.displayMedium!.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.phone,
                            style: textTheme.displayMedium!.copyWith(
                                color: purple,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: grey,
                  )
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: textTheme.displaySmall!
                    .copyWith(fontSize: 25, color: white),
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: textTheme.displaySmall!.copyWith(fontSize: 17),
                  filled: true,
                  suffix: const Icon(FontAwesomeIcons.circleXmark),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Text(
                      "Pay",
                      style: textTheme.displayMedium!.copyWith(
                          color: black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
