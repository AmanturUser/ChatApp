import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_ui/constants.dart';
import 'package:whatsapp_ui/data/chat_data.dart';
import 'package:whatsapp_ui/data/message_data.dart';
import 'package:whatsapp_ui/functions/custom_function.dart';
import 'package:whatsapp_ui/model/chat.dart';
import 'package:whatsapp_ui/model/message.dart';
import 'package:whatsapp_ui/provider/chat_provider.dart';
import 'package:whatsapp_ui/widgets/chat_message_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String friendName;
  String imageUrl;
  bool switchValue = false;
  List<Message> messagesList;
  TextEditingController message=TextEditingController();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 500.0);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int indexTemp=Provider.of<ChatProvider>(context).currentChatIndex;
    final Chat chat =
        ChatData.chats[Provider.of<ChatProvider>(context).currentChatIndex];
    friendName = chat.memberTwoName;
    imageUrl = chat.memberTwoProfilePicUrl;
    messagesList = chat.messagesList;

    return CustomFunctions.isMobile(context)
        ? Scaffold(
            body: _buildChat(indexTemp),
          )
        : _buildChat(indexTemp);
  }

  Container _buildChat(int indexTemp) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          _buildAppBar(context),
          _buildMessagesList(),
          _buildMessageComposer(indexTemp)
        ],
      ),
    );
  }

  Expanded _buildMessagesList() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatMessageWidget(messagesList[index]);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CustomFunctions.isMobile(context)
          ? CustomColors.kPrimaryColor
          : CustomColors.kLightColor,
      titleSpacing: 0.0,
      title: Row(
        children: [
          CustomFunctions.isMobile(context)
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : SizedBox(
                  width: 10.0,
                ),
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 20,
          ),
          SizedBox(width: 10.0),
          Text(
            friendName,
            style: TextStyle(
              color: CustomFunctions.isMobile(context)
                  ? CustomColors.kLightColor
                  : Colors.black,
            ),
          )
        ],
      ),
      actions: [
        /*Icon(
          Icons.video_call,
          color: CustomFunctions.isMobile(context)
              ? CustomColors.kLightColor
              : CustomColors.kIconColor,
        ),*/
        Switch(
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            }),
        SizedBox(width: 15.0),
        /*Icon(
          Icons.call,
          color: CustomFunctions.isMobile(context)
              ? CustomColors.kLightColor
              : CustomColors.kIconColor,
        ),*/
        switchValue
            ? Center(
                child: Text(
                'Открыто',
                style: TextStyle(color: Colors.green),
              ))
            : Center(
                child: Text(
                'Закрыто',
                style: TextStyle(color: Colors.red),
              )),
        SizedBox(width: 15.0),
        Icon(Icons.account_circle_outlined,color: Colors.grey,),
        SizedBox(width: 15.0),
        Icon(
          Icons.more_vert,
          color: CustomFunctions.isMobile(context)
              ? CustomColors.kLightColor
              : CustomColors.kIconColor,
        ),
      ],
    );
  }

  Widget _buildMessageComposer(int indexTemp) {
    final textField = Container(
      decoration: BoxDecoration(
        color: CustomColors.kLightColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0),
          Icon(
            Icons.add_circle_outline,
            color: CustomColors.kIconColor,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      width: 1, color: Colors.black.withOpacity(0.1))),
              child: Row(
                children: [
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                          hintText: 'Начни писать что-нибудь...',
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: CustomColors.kIconColor,
                  ),
                  SizedBox(width: 8.0),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
            icon:Icon(Icons.send,
              color: CustomColors.kIconColor,),
            onPressed: (){
              MessageData.messagesList[indexTemp].add(Message(senderNumber: '123456789',text: message.text,time: DateTime.now().hour.toString()));
              setState(() {
                message.text='';
              });
            },
            
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: textField),
          /*SizedBox(width: 8.0),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.mic),
          )*/
        ],
      ),
    );
  }
}
