import 'package:finflow/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Chat extends StatefulWidget {
  final Map<String?, String> chats;
  const Chat({super.key, required this.chats});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool waitingforResponse = false;
  TextEditingController textFieldController = TextEditingController();
  List<Widget> list = [];
  Map<String?, String> newchats = {};
  @override
  void initState() {
    super.initState();
    newchats = widget.chats;
    if (newchats.isEmpty) {
      newchats['Good Morning! How can I help you today?'] = 'Assistant';
    }
  }

  void updateChat(String message, String sender) {
    setState(() {
      newchats[message] = sender;
      newchats['Assistant reply to: $message'] = 'Assistant';
    });
  }

  Widget anstext(String? text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundColor: assistantCircleColor,
              child: Image.asset('images/virtualAssistant.png')),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 7).copyWith(top: 6),
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  text ?? 'Good Morning! How can I help you today?',
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: mainFontColor,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newtext(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 7).copyWith(top: 6),
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)
                      .copyWith(topRight: Radius.zero)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: mainFontColor,
                      fontSize: 17),
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: lightblue,
            child: Icon(
              Boxicons.bx_user,
              color: white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Assistant',
            style: TextStyle(fontFamily: 'CEra Pro'),
          ),
          leading: const Icon(Boxicons.bx_menu),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: assistantCircleColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('images/virtualAssistant.png'))),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: newchats.length,
                          itemBuilder: (context, index) {
                            final message = newchats.keys.elementAt(index);
                            final sender = newchats[message];
                            return sender == 'Assistant'
                                ? anstext(message)
                                : newtext(message!);
                          },
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextField(
                          onSubmitted: (value) {
                            updateChat(value, 'User');

                            FocusManager.instance.primaryFocus?.unfocus();
                            textFieldController.clear();
                          },
                          controller: textFieldController,
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter text here...',
                            hintStyle:
                                TextStyle(color: black, fontFamily: 'Century'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                updateChat(textFieldController.text, 'User');
                                FocusManager.instance.primaryFocus?.unfocus();
                                textFieldController.clear();
                              },
                              icon: const Icon(
                                Boxicons.bx_search_alt,
                                size: 27,
                              ),
                              color: black,
                            ),
                            filled: true,
                            fillColor: secondSuggestionBoxColor.withOpacity(.6),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          onPressed: () {},
                          child: const Icon(
                            Boxicons.bx_microphone,
                            size: 27,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
