import 'package:chats/chat/database_service/chat_database.dart';
import 'package:chats/chat/entity/chat.dart';
import 'package:chats/chat/store.dart/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.userId,
      required this.username,
      required this.friendUserId, required this.friendusername})
      : super(key: key);

  final String userId;
  final String username;
  final String friendusername;
  final String friendUserId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //instantiate user store
  ChatStore _chatStore = ChatStore();

  //for message
  final messageController = TextEditingController();

  //form key
  final _fKey = GlobalKey<FormState>();

   @override
  void didChangeDependencies() async {
    _chatStore = Provider.of<ChatStore>(context, listen: false);
    await _chatStore.getAllChats(widget.userId, widget.friendUserId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.friendusername),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          children: [
            //list
            Expanded(
              child: getAllMessage()
              ),
            Form(
              key: _fKey,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: FocusNode(),
                      decoration:
                          const InputDecoration(hintText: 'Write here..'),
                      controller: messageController,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return;
                        }

                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (_fKey.currentState!.validate()) {
                          if (messageController.text.trim().isNotEmpty) {
                            DateTime now =  DateTime.now();
                            final ChatData chatData = ChatData(
                                userId: widget.userId,
                                username: widget.username,
                                message: messageController.text.trim(),
                                date: DateTime.now()
                                );
                            print("date ${DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second)}");
                            print("date ${DateTime.now()}");
                            messageController.clear();
                            await _chatStore.saveChat(
                                chatData: chatData,
                                userId: widget.userId,
                                friendUserId: widget.friendUserId);
                            await _chatStore.getAllChats(
                                widget.userId, widget.friendUserId);
                          }
                        }
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAllMessage() {
    return Observer(builder: (context){
      if (_chatStore.chatList.isEmpty || _chatStore.chatList == null) {
      return const Center(child: Text('Start Conversation'));
    } else {
      return Observer(
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: _chatStore.chatList.length,
            itemBuilder: (context, index) {
              //sender
              if (_chatStore.chatList[index].userId == widget.userId) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Bubble(
                      margin: const BubbleEdges.only(top: 10),
                      alignment: Alignment.topRight,
                      nip: BubbleNip.rightTop,
                      color: Colors.blue,
                      child: Text(
                        _chatStore.chatList[index].message,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const Text("(you)", maxLines: 1, style: TextStyle(fontSize: 10),),
                    Text(_chatStore.chatList[index].date.toString(), maxLines: 1, style: const TextStyle(fontSize: 10),)
                  ],
                );
                //receiver
              } else if (_chatStore.chatList[index].userId ==
                  widget.friendUserId) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bubble(
                      margin: const BubbleEdges.only(top: 10),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      color: Colors.grey[50],
                      child: Text(
                        _chatStore.chatList[index].message,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(_chatStore.chatList[index].username, maxLines: 1, style: const TextStyle(fontSize: 10),),
                    Text(_chatStore.chatList[index].date.toString(), maxLines: 1, style: const TextStyle(fontSize: 10),)
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          );
        }
      );
    }
    });
    
  }
}
