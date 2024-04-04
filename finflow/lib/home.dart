import 'package:finflow/colors.dart';
import 'package:finflow/credit_card.dart';
import 'package:finflow/group.dart';
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
  List<String> CardBackground = [
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
                  SizedBox(
                    width: screenwidth,
                    height: screenheight * 0.33,
                    child: Swiper(
                      pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                          color: Color.fromARGB(255, 56, 56, 56),
                          activeColor: Color.fromRGBO(162, 146, 246, 1),
                        ),
                      ),
                      itemWidth: screenwidth - 40,
                      viewportFraction: 0.85,
                      scale: 0.87,
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
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
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
                          color: colors[index],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        );
                      },
                    ),
                  ),
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
                          ? AnimationLimiter(
                              child: GridView.builder(
                                itemCount: totalgroups + 1,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                  builder: (context) =>
                                                      const CreateGroup(),
                                                  enableDrag: true,
                                                  showDragHandle: true,
                                                  isScrollControlled: true));
                                        },
                                        child: DottedBorder(
                                          strokeWidth: 1,
                                          dashPattern: const [3, 3],
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(15),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
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
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: ScaleAnimation(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        CardBackground[
                                                            index - 1])),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    CardBackground[index - 1])),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        );
                                },
                              ),
                            )
                          : Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        ModalBottomSheetRoute(
                                            builder: (context) =>
                                                const CreateGroup(),
                                            enableDrag: true,
                                            showDragHandle: true,
                                            isScrollControlled: true));
                                  },
                                  child: DottedBorder(
                                    strokeWidth: 1,
                                    dashPattern: const [3, 3],
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(15),
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      4,
                                      (index) {
                                        final containerSize = screenwidth / 7.7;
                                        return Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: containerSize,
                                                height: containerSize,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          CardBackground[
                                                              index])),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Trip",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    "Owe:\$100",
                                                    style: textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 10),
                                                  ),
                                                  Text(
                                                    "Debt \$100",
                                                    style: textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color: Colors.green,
                                                            fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                            ),
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
              sliver: AnimationLimiter(
                child: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 8,
                      crossAxisCount: 4,
                      childAspectRatio: 0.83),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5)
                                          .copyWith(top: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 56, 56, 56),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Yash Nautiyal",
                                        textAlign: TextAlign.center,
                                        style: textTheme.displaySmall!.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
