import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_app/ui/chat/bloc/chatbot_bloc.dart';
import 'package:tp_app/ui/chat/repository/DialogFlowRepository.dart';

import '../app_bar/custom_app_bar.dart';
import 'aminated_listeg.dart';
import 'chat_message.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  static const String routeName = "/chatPage";

  @override
  State createState() => new ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<ChatMessage> _list;

  final TextEditingController textEditingController =
      new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  static DialogFlowRepository _dialogFlowRepository = DialogFlowRepository();
  ChatbotBloc _chatbotBloc = ChatbotBloc(_dialogFlowRepository);

  @override
  void initState() {
    super.initState();
    warmUpFunction();
    _chatbotBloc.add(SendMessage("hello"));

    _list = ListModel<ChatMessage>(
      listKey: _listKey,
      initialItems: <ChatMessage>[
        ChatMessage(
          text: "hello",
        )
      ],
    );
  }

  void warmUpFunction(){
    http.get('https://us-central1-tp-app-aff2e.cloudfunctions.net/api/test');
  }

  void _handleSubmit(String text) {
    textEditingController.clear();
    ChatMessage chatMessage = new ChatMessage(text: text, user: false);
    setState(() {
      _list.insert(0, chatMessage);
      // _dialogFlowRepository
      //     .dialogFlowChat(text)
      //     .then((value) => receivedMessage(value));
    });
  }

  void receivedMessage(List text) {
    print(text);
    print(text[0]['text']['text'][0]);
    String message = text[0]['text']['text'][0];
    print(message);
    bool card = false;
    var arr = List();
    List<Widget> buttons = List();
    try {
      String messageFromAlgolia =
          jsonDecode(text[0]['text']['text'][0])['objectID'];
      if (messageFromAlgolia != null) {
        print("card detected");
        card = true;
      }
    } on FormatException catch (e) {
      print(e);
    } catch (error) {
      print("No card detected");
    }

    try {
      arr = text[1]['payload']['buttons'];
    } catch (e) {
      // RangeError (index): Invalid value: Only valid value is 0: 1
      print("No buttons detected");
      arr = null;
      print(e);
    }
    if (arr != null) {
      print("array not null");
      arr.forEach((f) {
        buttons.add(RaisedButton(
          color: Theme.of(context).cardColor,
          child: Text(f),
          onPressed: () {
            _chatbotBloc.add(SendMessage(f));

            _handleSubmit(f);
          },
        ));
      });
    }

    if (text == null) {
      message = "error";
      print("message is null");
    }
    //return array from payload
    // print(text[1]['payload']['buttons']);
    setState(() {
      print(card);
      _list.insert(
          0,
          ChatMessage(
            context: context,
            text: message,
            buttons: buttons,
            user: true,
            card: card,
          ));
    });
  }

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter your message"),
                controller: textEditingController,
                // onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  // onPressed: () => _handleSubmit(textEditingController.text),
                  onPressed: () {
                    ChatMessage chatMessage = new ChatMessage(
                        text: textEditingController.text, user: false);

                    setState(() {
                      _list.insert(0, chatMessage);
                    });
                    _chatbotBloc.add(SendMessage(textEditingController.text));
                    textEditingController.clear();
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _chatbotBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chatbotBloc,
      child: BlocListener(
        bloc: _chatbotBloc,
        listener: (BuildContext context, ChatbotState state) {
          if (state is ChatbotSendMessage) {}
          if (state is ChatbotMessageReceived) {
            receivedMessage(state.message);
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(),
          body: SafeArea(
            bottom: true,
            child: Column(
              children: <Widget>[
                new Flexible(
                    child: AnimatedList(
                  reverse: true,
                  key: _listKey,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: CurvedAnimation(
                        curve: Curves.easeOut,
                        parent: animation,
                      ).drive((Tween<Offset>(
                        begin: Offset(1, 0),
                        end: Offset(0, 0),
                      ))),
                      child: _list[index],
                    );
                  },
                )),
                new Divider(
                  height: 1.0,
                ),
                new Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: _textComposerWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
