import 'package:chatbot_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool loading;
  final String text;
  final ChatMessageType chatMessageType;

  const ChatMessageWidget({
    super.key,
    this.loading = false,
    required this.text,
    required this.chatMessageType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.background,
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        chatMessageType == ChatMessageType.bot
            ? Container(
                // for bot
                margin: const EdgeInsets.only(right: 16, top: 55),
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(16, 163, 127, 1),
                  child: Image.asset("assets/gpt.png"),
                ),
              )
            : Container(
                //for user
                margin: const EdgeInsets.only(right: 16),
                child: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
        Expanded(
          child: Column(
            children: <Widget>[
              if (!loading)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              if (loading)
                Shimmer.fromColors(
                  baseColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5),
                  highlightColor: Colors.yellow,
                  child: Text(
                    'Loading ...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
            ],
          ),
        ),
      ]),
    );
  }
}
