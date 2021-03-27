import 'package:flutter/material.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/inbox_model/chat_model.dart';
import 'package:ma_laundry/data/model/inbox_model/inbox_model.dart';
import 'package:ma_laundry/ui/bloc/inbox_bloc/chat_bloc.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final DataInbox data;

  const ChatPage({Key key, this.data}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DataInbox get data => widget.data;
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatBloc(context, data)),
        ChangeNotifierProvider(create: (contex) => ConnecttivityHandler()),
      ],
      child: Consumer<ConnecttivityHandler>(
        builder: (context, connect, child) => Consumer<ChatBloc>(
          builder: (context, chatBloc, _) => Scaffold(
            appBar: AppBar(
              title: Text(() {
                return "Chat";
              }()),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: whiteNeutral,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                errorConnectWidget(context),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        chatBloc.isLoading
                            ? Expanded(child: circularProgressIndicator())
                            : chatBloc.listDataChat.length == 0
                                ? Expanded(child: notFoundDataStatus())
                                : Expanded(
                                    child: ListView.builder(
                                      controller: chatBloc.controller,
                                      itemCount: chatBloc.listDataChat.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DataChat data =
                                            chatBloc.listDataChat[index];
                                        if (data?.idSender ==
                                            "${accountData?.account?.id}") {
                                          return senderWidget(data?.chat,
                                              time: data?.createdDate);
                                        } else {
                                          return receiverWidget(data);
                                        }
                                      },
                                    ),
                                  ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  onTap: () => chatBloc.scrollToBottom(),
                                  decoration:
                                      InputDecoration(hintText: 'tulis pesan'),
                                  controller: chatController,
                                  minLines: 1,
                                  maxLines: 5,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: primaryColor,
                                ),
                                onPressed: () async {
                                  await chatBloc.sendChat(data, chatController);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
