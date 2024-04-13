import 'dart:math';

import 'package:finflow/pages/transfer/amount.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/controllers/fetch_controller.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  bool numkeyboard = false;
  final fetch = Get.put(FetchController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 17, right: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Money',
              style: textTheme.displayMedium!
                  .copyWith(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 17.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      keyboardType: numkeyboard
                          ? TextInputType.phone
                          : TextInputType.name,
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: textTheme.displaySmall!
                          .copyWith(fontSize: 16, color: white),
                      decoration: InputDecoration(
                        hintText: 'Enter Name or Mobile Number',
                        hintStyle:
                            textTheme.displaySmall!.copyWith(fontSize: 15),
                        prefixIcon: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: purple,
                          size: 20,
                        ),
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(19)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          numkeyboard = !numkeyboard;
                        });
                      },
                      child: Icon(
                        numkeyboard
                            ? Icons.format_list_numbered_outlined
                            : FontAwesomeIcons.addressBook,
                        color: purple,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Contacts',
              style: textTheme.displayMedium!
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder<List<UserModal2>>(
                future: fetch.getallusers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final String name =
                              "${snapshot.data![index].firstname} ${snapshot.data![index].lastname}";
                          final String phno = snapshot.data![index].phno;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  ModalBottomSheetRoute(
                                      builder: (context) {
                                        double height =
                                            MediaQuery.of(context).size.height *
                                                0.8;
                                        return SizedBox(
                                          height: height,
                                          child: Amount(
                                            name: name,
                                            phone: phno,
                                          ),
                                        );
                                      },
                                      showDragHandle: true,
                                      isScrollControlled: true));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Initicon(
                                        text:
                                            "${snapshot.data![index].firstname} ${snapshot.data![index].lastname}",
                                        backgroundColor:
                                            niceColors[Random().nextInt(19)],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.displayMedium!
                                                .copyWith(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            phno,
                                            style: textTheme.displayMedium!
                                                .copyWith(
                                                    color: purple,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
