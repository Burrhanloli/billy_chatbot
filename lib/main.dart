import 'package:billy_chatbot/components/bubble.dart';
import 'package:billy_chatbot/components/card.dart';
import 'package:billy_chatbot/components/giphy.dart';
import 'package:billy_chatbot/components/options.dart';
import 'package:billy_chatbot/components/quick_replies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final messageEditingController = TextEditingController();
  List<Map> messages = List();
  bool isTextFieldHidden = true;

  void getChatBotResponse(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/billy_chatbot.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    for (var message in aiResponse.getListMessage()) {
      print(message);
      if (message["payload"] != null) {
        var payload = message["payload"];
        if (payload["quickReplies"] != null) {
          setState(() {
            messages.insert(0, {
              "data": 0,
              "message": payload["quickReplies"],
              "type": "QUICK_REPLIES",
            });
            isTextFieldHidden = true;
          });
        }
        if (payload["giphy"] != null) {
          setState(() {
            messages.insert(0, {
              "data": 0,
              "message": payload["giphy"],
              "type": "GIPHY",
            });
            isTextFieldHidden = true;
          });
        }
        if (payload["card"] != null) {
          setState(() {
            messages.insert(0, {
              "data": 0,
              "message": payload["card"],
              "type": "CARD",
            });
            isTextFieldHidden = true;
          });
        }
        if (payload["options"] != null) {
          setState(() {
            messages.insert(0, {
              "data": 0,
              "message": payload["options"],
              "type": "OPTIONS",
            });
            isTextFieldHidden = false;
          });
        }
      }
      if (message["text"] != null) {
        setState(() {
          messages.insert(0, {
            "data": 0,
            "message": message["text"]["text"][0],
            "type": "TEXT"
          });
          isTextFieldHidden = true;
        });
      }
    }
  }

  void callFromQuickReplies(String value) {
    messages.removeWhere((element) => element["type"] == "QUICK_REPLIES");
    setState(() {
      messages.insert(0, {"data": 1, "message": value});
    });
    getChatBotResponse(value);
  }

  void callFromOptions(String value) {
    messages.removeWhere((element) => element["type"] == "OPTIONS");
    setState(() {
      messages.insert(0, {"data": 1, "message": value});
    });
    getChatBotResponse(value);
  }

  Widget conversationBasedonType(message) {
    switch (message["type"]) {
      case "TEXT":
        return MessageBubble(
            message: message["message"].toString(), data: message["data"]);
      case "QUICK_REPLIES":
        return MessageQuickReplies(
            list: message["message"], notifyParent: callFromQuickReplies);
      case "GIPHY":
        return MessageGiphy(link: message["message"]);
      case "CARD":
        return MessageCard(
          message: message["message"],
        );
      case "OPTIONS":
        return MessageOptions(
            list: message["message"], notifyParent: callFromOptions);
      default:
        return MessageBubble(
            message: message["message"].toString(), data: message["data"]);
    }
  }

  @override
  void initState() {
    super.initState();
    getChatBotResponse("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Billy Chat Bot",
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      conversationBasedonType(messages[index]),
                ),
              ),
              Divider(
                height: 5.0,
                color: Colors.blue,
              ),
              if (isTextFieldHidden)
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: TextField(
                        controller: messageEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: "Send your message",
                        ),
                      )),
                      Container(
                        child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              final snackBar = SnackBar(
                                content: Text('Cannot send empty message.'),
                                duration: Duration(seconds: 1),
                              );
                              if (messageEditingController.text.isEmpty) {
                                _scaffoldKey.currentState
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  messages.insert(0, {
                                    "data": 1,
                                    "message": messageEditingController.text
                                  });
                                });
                                getChatBotResponse(
                                    messageEditingController.text);
                                messageEditingController.clear();
                              }
                            }),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
