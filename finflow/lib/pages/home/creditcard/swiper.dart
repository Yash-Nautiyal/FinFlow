import 'package:finflow/pages/home/creditcard/credit_card.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Swiper makeSwiper(double screenwidth, TextTheme textTheme,
    AsyncSnapshot<List<UserModal>> snapshot) {
  List<String> cardBackground = [
    'images/card/Card.jpg',
    'images/card/Card2.jpg',
    'images/card/Card3.jpg',
    'images/card/Card4.jpg'
  ];
  return Swiper(
    pagination: const SwiperPagination(
      alignment: Alignment.bottomCenter,
      builder: DotSwiperPaginationBuilder(
        color: Color.fromARGB(255, 56, 56, 56),
        activeColor: Color.fromRGBO(162, 146, 246, 1),
      ),
    ),
    itemWidth: screenwidth - 40,
    viewportFraction: 0.86,
    scale: 0.9,
    itemCount: snapshot.data!.length + 1,
    loop: false,
    index: snapshot.data!.isNotEmpty ? 1 : 0,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      if (index == 0) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                ModalBottomSheetRoute(
                    builder: (context) => const CreditCard(),
                    showDragHandle: true,
                    useSafeArea: true,
                    isScrollControlled: true));
          },
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: const Icon(FontAwesomeIcons.plus),
          ),
        );
      }
      return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              opacity: 0.7,
              image: AssetImage(
                  cardBackground[index]), // Use AssetImage to load the image
              fit: BoxFit.cover, // Set the fit property as required
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 100,
                    height: 40,
                    child: Image.asset(
                      'images/visa-white.png',
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            3,
                            (index) => SizedBox(
                              width: 65,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                  4,
                                  (index) => Container(
                                    width: 11,
                                    height: 11,
                                    decoration: BoxDecoration(
                                        color: white, shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        snapshot.data![index - 1].cardnumber
                            .toString()
                            .substring(
                                snapshot.data![index - 1].cardnumber.length -
                                    4),
                        style: textTheme.displayMedium!.copyWith(
                            color: white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Balance',
                        style: textTheme.displayMedium!.copyWith(
                            color: white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    const Icon(FontAwesomeIcons.lock)
                  ],
                ),
                Text('\$234.12',
                    style: textTheme.displayMedium!.copyWith(
                        color: white,
                        fontSize: 35,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      );
    },
  );
}
