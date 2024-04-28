import 'package:finflow/screens.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/controllers/Add_controller.dart';
import 'package:finflow/utils/firebase/controllers/fetch_controller.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Amount extends StatefulWidget {
  final String name;
  final String phone;
  const Amount({super.key, required this.name, required this.phone});

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  final fetchController = FetchController.instance;

  Map<String, Map<String, Map<String, String>>> groupDetailsMap = {};
  @override
  void initState() {
    super.initState();
    getGroupDetails(widget.phone.replaceAll('+91', '').replaceAll(' ', ''));
  }

  Future<void> getGroupDetails(String phoneNumber) async {
    final List<UserModal3?> groupDetails =
        await fetchController.getGroupForTransaction(phoneNumber,
            Screens.phonenumber.replaceAll('+91', '').replaceAll(' ', ''));

    if (groupDetails.isNotEmpty) {
      setState(() {
        for (final group in groupDetails) {
          if (group != null) {
            final innerdata = {
              "moto": group.moto, // Handling nullable moto
              // Assuming image is a String containing the image URL/path
              "image": group.image, // Handling nullable image
            };
            final groupdata = {group.id!: innerdata}; // Handling nullable id
            groupDetailsMap[group.grpname] =
                groupdata; // Handling nullable groupname
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final add = Get.put(AddController());
    String amount = "";
    TextTheme textTheme = Theme.of(context).textTheme;
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
                onChanged: (value) {
                  amount = value;
                },
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
              const SizedBox(
                height: 10,
              ),
              Text(
                "Groups",
                style: textTheme.displayMedium!
                    .copyWith(fontSize: 23, fontWeight: FontWeight.w600),
              ),
              Row(children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      child: Divider(
                        thickness: 1.2,
                        color: purple,
                      )),
                ),
                const Icon(Icons.keyboard_double_arrow_down_rounded),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(
                        left: 5.0,
                      ),
                      child: Divider(
                        thickness: 1.2,
                        color: purple,
                      )),
                ),
              ]),
              groupDetailsMap.isEmpty
                  ? const SizedBox.shrink()
                  : Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          itemCount: groupDetailsMap.length,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final grpname =
                                groupDetailsMap.keys.elementAt(index);
                            final grpidMap = groupDetailsMap[
                                grpname]; // Get the map for the group ID
                            if (grpidMap != null) {
                              final grpid =
                                  grpidMap.keys.first; // Get the group ID
                              final groupData =
                                  grpidMap[grpid]; // Get the group data
                              if (groupData != null) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  groupData["image"] ?? "",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            grpname,
                                            style: textTheme.displaySmall!
                                                .copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            groupData["moto"] ?? "",
                                            style: textTheme.displaySmall!
                                                .copyWith(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                            // If any required data is null, return an empty container
                            return Container();
                          },
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
                  onPressed: () async {
                    final name = await retrieveData('Name');
                    final phno = await retrieveData('Phone');
                    final user = UserModal4(
                        to: {widget.name: widget.phone},
                        from: {name: phno},
                        amount: amount);
                    add.addtransaction(user);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Pay",
                    style: textTheme.displayMedium!.copyWith(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
