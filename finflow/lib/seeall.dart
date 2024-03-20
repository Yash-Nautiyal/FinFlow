import 'package:finflow/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  final Map<String, List<IconData>> categoryIcons = {
    'Bill': [
      FontAwesomeIcons.bolt,
      Icons.wifi,
      FontAwesomeIcons.droplet,
      FontAwesomeIcons.wallet,
      Boxicons.bxs_tv,
      FontAwesomeIcons.cartShopping,
      FontAwesomeIcons.mobile,
      FontAwesomeIcons.creditCard,
    ],
    'Insurance': [
      Icons.medical_services_rounded,
      FontAwesomeIcons.motorcycle,
      FontAwesomeIcons.car
    ],
    'Other': [
      FontAwesomeIcons.shieldHeart,
      FontAwesomeIcons.bagShopping,
      Boxicons.bxs_discount,
      Boxicons.bx_bar_chart_square
    ],
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              const Text(
                'All Services',
                style: TextStyle(
                    fontFamily: 'CEra Pro',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Boxicons.bx_dots_horizontal_rounded),
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoryIcons.keys.toList().map((categoryName) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text with divider for each category
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontFamily: 'Century',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(),

                      // Grid view for each category's icons using GridView.builder
                      AnimationLimiter(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryIcons[categoryName]!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 1.5,
                            mainAxisExtent: 100,
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, index) {
                            final iconData =
                                categoryIcons[categoryName]![index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                curve: Easing.standardDecelerate,
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 8,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(17),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: borderColor),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          color: getColorForIcon(iconData)
                                              .keys
                                              .first
                                              .withOpacity(.15),
                                        ),
                                        child: Icon(
                                          iconData,
                                          color: getColorForIcon(iconData)
                                              .keys
                                              .first,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 80,
                                      child: Text(
                                        getColorForIcon(iconData).values.first,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Cera Pro',
                                            fontWeight: FontWeight.bold,
                                            height: 1.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<Color, String> getColorForIcon(IconData iconData) {
    // Logic to define color based on icon (modify or remove if colors are already defined)
    switch (iconData) {
      case FontAwesomeIcons.droplet:
        return {Colors.blue: 'Water'};
      case FontAwesomeIcons.wallet:
        return {Colors.purple: 'Wallet'};
      case Boxicons.bxs_tv:
        return {const Color.fromARGB(255, 33, 61, 243): 'Television'};
      case FontAwesomeIcons.cartShopping:
        return {Colors.deepPurple: 'Merchant'};
      case FontAwesomeIcons.creditCard:
        return {Colors.deepOrange: 'Installments'};
      case FontAwesomeIcons.bolt:
        return {const Color.fromARGB(255, 244, 203, 80): 'Electricity'};
      case Icons.wifi:
        return {const Color.fromARGB(255, 248, 144, 7): 'Internet'};
      case Icons.medical_services_rounded:
        return {Colors.green: 'Assurance'};
      case FontAwesomeIcons.shieldHeart:
        return {Colors.lightGreen: 'Health'};
      case FontAwesomeIcons.bagShopping:
        return {Colors.orangeAccent: 'Shopping'};
      case Boxicons.bxs_discount:
        return {Colors.pinkAccent: 'Deals'};
      case FontAwesomeIcons.mobile:
        return {Colors.lightBlueAccent: 'Mobile'};
      case FontAwesomeIcons.motorcycle:
        return {Colors.brown: 'Motor'};
      case FontAwesomeIcons.car:
        return {Colors.blueGrey: 'Car'};
      case Boxicons.bx_bar_chart_square:
        return {Colors.greenAccent: 'Invest'};
      default:
        return {Colors.grey: ''};
      // Default color for unknown icons
    }
  }
}
