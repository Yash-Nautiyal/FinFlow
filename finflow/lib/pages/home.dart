import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/widgets/credit_card.dart';
import 'package:finflow/utils/widgets/CreateGroup.dart';
import 'package:finflow/utils/widgets/group.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<String> groupBackground = [
    'images/poly/poly1.png',
    'images/poly/poly2.png',
    'images/poly/poly3.png',
    'images/poly/poly4.png',
    'images/poly/poly5.png',
    'images/poly/poly6.png',
    'images/poly/poly7.png',
    'images/poly/poly8.png',
    'images/poly/poly9.png',
    'images/poly/poly10.jpg',
  ];
  List<String> cardBackground = [
    'images/card/Card.jpg',
    'images/card/Card2.jpg',
    'images/card/Card3.jpg',
    'images/card/Card4.jpg'
  ];

  List<Color> colors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    /* Colors.pinkAccent,
    Colors.limeAccent,
    Colors.orangeAccent,
    Colors.cyanAccent, */
  ];
  int totalgroups = 10;
  bool viewall = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0)
                        .copyWith(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style:
                              textTheme.displayMedium!.copyWith(fontSize: 15),
                        ),
                        Text(
                          'Johnny Jibs',
                          style: textTheme.displayMedium!.copyWith(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  creditCardSwiper(screenwidth, screenheight, textTheme),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Groups",
                      style: textTheme.displayMedium!.copyWith(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: screenwidth,
                      height: viewall ? screenheight * .2 : screenheight * .13,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 56, 56, 56),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: viewall
                          ? groupsGrid()
                          : firstfourgroups(context, screenwidth, textTheme),
                    ),
                  ),
                  viewall
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              viewall = false;
                            });
                          },
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: Icon(FontAwesomeIcons.circleArrowUp),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)
                        .copyWith(top: 5),
                    child: Row(
                      children: [
                        Text(
                          "Recent transactions",
                          style:
                              textTheme.displayMedium!.copyWith(fontSize: 20),
                        ),
                        const Spacer(),
                        Text(
                          "See All",
                          style: textTheme.displaySmall!.copyWith(
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                              decorationColor: purple,
                              color: purple),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              sliver:
                  recentTrasactionsGrid(screenwidth, screenheight, textTheme),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox creditCardSwiper(
      double screenwidth, double screenheight, TextTheme textTheme) {
    return SizedBox(
      width: screenwidth,
      height: screenheight * 0.3,
      child: Swiper(
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Color.fromARGB(255, 56, 56, 56),
            activeColor: Color.fromRGBO(162, 146, 246, 1),
          ),
        ),
        itemWidth: screenwidth - 40,
        viewportFraction: 0.872,
        scale: 0.89,
        itemCount: 4,
        loop: false,
        index: 1,
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
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  opacity: 0.7,
                  image: AssetImage(cardBackground[
                      index]), // Use AssetImage to load the image
                  fit: BoxFit.cover, // Set the fit property as required
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
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
                              child: Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      3,
                                      (index) => Container(
                                            width: 65,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                  4,
                                                  (index) => Container(
                                                        width: 11,
                                                        height: 11,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: white,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )),
                                            ),
                                          )),
                                ),
                              )),
                          Expanded(
                            child: Text(
                              '1234',
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
                          Icon(FontAwesomeIcons.lock)
                        ],
                      ),
                      Text('\$234.12',
                          style: textTheme.displayMedium!.copyWith(
                              color: white,
                              fontSize: 35,
                              fontWeight: FontWeight.w700)),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  AnimationLimiter recentTrasactionsGrid(
      double screenwidth, double screenheight, TextTheme textTheme) {
    return AnimationLimiter(
      child: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8, crossAxisCount: 4, childAspectRatio: 0.83),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 4,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 400),
                child: Stack(
                  children: [
                    SizedBox(
                      width: screenwidth / 4,
                      height: screenheight / 4,
                    ),
                    Positioned(
                      bottom: 0,
                      top: 20,
                      left: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5)
                            .copyWith(top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 56, 56, 56),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Yash Nautiyal",
                              textAlign: TextAlign.center,
                              style: textTheme.displaySmall!.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: 7,
        ),
      ),
    );
  }

  AnimationLimiter groupsGrid() {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: totalgroups + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 7,
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  totalgroups++;
                });
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      ModalBottomSheetRoute(
                          builder: (context) => const CreateGroup(),
                          enableDrag: true,
                          showDragHandle: true,
                          isScrollControlled: true));
                },
                child: DottedBorder(
                  strokeWidth: 1,
                  dashPattern: const [3, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(FontAwesomeIcons.plus),
                  ),
                ),
              ),
            );
          }
          return index > 4
              ? AnimationConfiguration.staggeredGrid(
                  columnCount: 5,
                  position: index,
                  duration: const Duration(milliseconds: 300),
                  child: ScaleAnimation(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(groupBackground[index - 1])),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(groupBackground[index - 1])),
                    borderRadius: BorderRadius.circular(15),
                  ),
                );
        },
      ),
    );
  }

  Row firstfourgroups(
      BuildContext context, double screenwidth, TextTheme textTheme) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                ModalBottomSheetRoute(
                    builder: (context) => const CreateGroup(),
                    enableDrag: true,
                    showDragHandle: true,
                    isScrollControlled: true));
          },
          child: DottedBorder(
            strokeWidth: 1,
            dashPattern: const [3, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            child: const SizedBox(
              width: 55,
              height: 55,
              child: Icon(FontAwesomeIcons.plus),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) {
                final containerSize = screenwidth / 7.7;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Group(
                                    title: 'Trip',
                                    bgimage: groupBackground[index],
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: containerSize,
                              height: containerSize,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(groupBackground[index])),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: green, shape: BoxShape.circle),
                                ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Trip",
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.displaySmall!.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Owe:\$100",
                              style: textTheme.displaySmall!
                                  .copyWith(color: Colors.red, fontSize: 10),
                            ),
                            Text(
                              "Debt \$100",
                              style: textTheme.displaySmall!
                                  .copyWith(color: Colors.green, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        totalgroups > 4
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    viewall = true;
                  });
                },
                child: Text(
                  '+${totalgroups - 4}',
                  style: textTheme.titleMedium,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
