import 'dart:math';

import 'package:finflow/pages/home/creditcard/swiper.dart';
import 'package:finflow/pages/home/widgets/name_image.dart';
import 'package:finflow/screens.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/pages/home/creditcard/credit_card.dart';
import 'package:finflow/pages/home/splitgroup/CreateGroup.dart';
import 'package:finflow/pages/home/splitgroup/group.dart';
import 'package:finflow/utils/firebase/controllers/fetch_controller.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
  ];
  int totalgroups = 10;
  bool viewall = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final fetch = Get.put(FetchController());
    final TextTheme textTheme = Theme.of(context).textTheme;
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    Map<String, String> recent = {
      'Kabir Yadav': '-\$100',
      'Palash Dey': '+\$20',
      'Shrey Goel': '+\$104',
      'Kshitiz Saxena': '-\$150',
      'Mohit Roy': '-\$300'
    };

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
                    child: Row(
                      children: [
                        nameimage(45),
                        const SizedBox(
                          width: 9,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: textTheme.displayMedium!
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              Screens.Name,
                              style: textTheme.displayMedium!
                                  .copyWith(fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  creditCardSwiper(screenwidth, screenheight, textTheme, fetch),
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
                          ? groupsGrid(fetch, screenwidth, textTheme)
                          : firstfourgroups(
                              context, screenwidth, textTheme, fetch),
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
              sliver: recentTrasactionsGrid(
                  screenwidth, screenheight, textTheme, recent),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox creditCardSwiper(double screenwidth, double screenheight,
      TextTheme textTheme, FetchController fetch) {
    return SizedBox(
        width: screenwidth,
        height: screenheight * 0.3,
        child: FutureBuilder<String?>(
          future: retrieveData('UserID'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final userid = snapshot.data;
              if (userid != null) {
                return FutureBuilder<List<UserModal>>(
                  future: fetch.getallcards("${userid}Cards"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
/*                       print('object');
 */
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
/*                         print(snapshot.data.toString());
 */
                        return makeSwiper(screenwidth, textTheme, snapshot);
                      } else if (snapshot.hasError) {
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
                      } else {
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
                    } else {
                      return Center(
                        child: SpinKitDoubleBounce(
                          color: purple,
                        ),
                      );
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ));
  }

  AnimationLimiter recentTrasactionsGrid(double screenwidth,
      double screenheight, TextTheme textTheme, Map<String, String> recent) {
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
                      child: Material(
                        elevation: 9,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5)
                              .copyWith(top: 25, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 56, 56, 56),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                recent.keys.elementAt(index).split(" ")[0],
                                textAlign: TextAlign.center,
                                style: textTheme.displaySmall!
                                    .copyWith(fontSize: 17, color: white),
                              ),
                              const Spacer(),
                              Text(
                                recent.values.elementAt(index),
                                textAlign: TextAlign.center,
                                style: textTheme.displaySmall!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: recent.values
                                            .elementAt(index)
                                            .startsWith("-")
                                        ? Colors.redAccent
                                        : green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 27,
                      right: 27,
                      child: Initicon(
                          size: 40,
                          text: recent.keys.elementAt(index),
                          backgroundColor: niceColors[
                              Random().nextInt(niceColors.length - 1)]),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: recent.length,
        ),
      ),
    );
  }

  FutureBuilder groupsGrid(FetchController fetchController, double screenwidth,
      TextTheme textTheme) {
    return FutureBuilder<String?>(
      future: retrieveData("UserID"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final userid = snapshot.data;
          if (userid != null) {
            return FutureBuilder<List<UserModal3>>(
              future: fetchController.getallgroups("${userid}Groups"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return AnimationLimiter(
                      child: GridView.builder(
                        itemCount: snapshot.data!.length + 1,
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
                                            image: AssetImage(
                                                groupBackground[index - 1])),
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
                                        image: AssetImage(
                                            groupBackground[index - 1])),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.hasError}"),
                    );
                  } else {
                    return GestureDetector(
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
                    );
                  }
                } else {
                  return Center(
                    child: SpinKitDoubleBounce(
                      color: purple,
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.hasError}"),
            );
          } else {
            return SizedBox();
          }
        } else {
          return Center(
            child: SpinKitDoubleBounce(
              color: purple,
            ),
          );
        }
      },
    );
  }

  FutureBuilder firstfourgroups(BuildContext context, double screenwidth,
      TextTheme textTheme, FetchController fetchController) {
    return FutureBuilder(
        future: retrieveData("UserID"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final userid = snapshot.data;
            if (userid != null) {
              return FutureBuilder<List<UserModal3>>(
                  future: fetchController.getallgroups("${userid}Groups"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Row(
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
                                children: List.generate(
                                  snapshot.data!.length,
                                  (index) {
                                    print(snapshot.data![index].id);

                                    final containerSize = screenwidth / 7.7;
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Group(
                                                          docname: snapshot
                                                              .data![index].id!,
                                                          title: snapshot
                                                              .data![index]
                                                              .grpname,
                                                          bgimage:
                                                              groupBackground[
                                                                  index],
                                                        )));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
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
                                                              groupBackground[
                                                                  index])),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: green,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                snapshot.data![index].grpname,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.displaySmall!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                "Owe:\$100",
                                                style: textTheme.displaySmall!
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            snapshot.data!.length > 4
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
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error Loading Data'));
                      } else {
                        return GestureDetector(
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            child: const SizedBox(
                              width: 55,
                              height: 55,
                              child: Icon(FontAwesomeIcons.plus),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: SpinKitDoubleBounce(
                          color: purple,
                        ),
                      );
                    }
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text("An error occured"));
            } else {
              return Container();
            }
          } else {
            return Center(
              child: SpinKitDoubleBounce(
                color: purple,
              ),
            );
          }
        });
  }
}
