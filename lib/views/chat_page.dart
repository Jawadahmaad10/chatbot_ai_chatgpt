import 'package:chatbot_app/model/model.dart';
import 'package:chatbot_app/views/widgets/chat_message.dart';
import 'package:flutter/material.dart';

import '../controller/generate_response.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 70,
        title: const Text(
          'ChatGpt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: IconButton(
        icon: const Icon(
          Icons.send_rounded,
        ),
        onPressed: () async {
          //display user input
          setState(
            () {
              _messages.add(
                ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.user,
                ),
              );
              isLoading = true;
            },
          );
          final input = _textController.text;
          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => _scrollDown());
          generateResponse(input).then((value) {
            setState(() {
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: value,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
            });
          });
          _textController.clear();
          Future.delayed(const Duration(milliseconds: 50)).then(
            (_) => _scrollDown(),
          );
        },
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: TextField(
        enabled: !isLoading,
        controller: _textController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          border: InputBorder.none,
          hintText: isLoading ? 'Loading . . .' : 'Write something here',
        ),
      ),
    ));
  }

  ListView _buildList() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: isLoading ? _messages.length + 1 : _messages.length,
        itemBuilder: (context, index) {
          try {
            var message = _messages[index];
            return ChatMessageWidget(
                text: message.text, chatMessageType: message.chatMessageType);
          } catch (e) {
            return const ChatMessageWidget(
                text: 'Loading',
                loading: true,
                chatMessageType: ChatMessageType.bot);
          }
        });
  }

  // this function for scrolling down when response is generated
  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}


//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


// In the code snippet you provided, you have declared a late boolean variable isLoading. It is initialized as false in the initState() method of a Flutter widget. Then, you have a TextField widget where the enabled property is set based on the value of isLoading, and the hintText property is set dynamically using a conditional expression.

// Here's an explanation of the code:

// dart
// Copy code
// late bool isLoading;

// @override
// void initState() {
//   super.initState();
//   isLoading = false; // Initializing isLoading as false in the initState() method
// }

// TextField(
//   enabled: !isLoading, // The enabled property is set to the opposite value of isLoading
//   hintText: isLoading ? 'Loading . . .' : 'Write something here',
// )
// In this example, the isLoading variable is initialized as false in the initState() method, which is an appropriate place to initialize stateful variables in a Flutter widget's lifecycle.

// The TextField widget has the enabled property set to !isLoading, which means it will be enabled (true) when isLoading is false, and disabled (false) when isLoading is true. This can be useful if you want to prevent user input or interaction while a loading operation is in progress.

// The hintText property of the TextField is set using a conditional expression. If isLoading is true, it will display 'Loading . . .' as the hint text, indicating that the app is in a loading state. If isLoading is false, it will display 'Write something here' as the default hint text, prompting the user to enter text.

// Remember to update the value of isLoading appropriately based on the loading state of your application or any other relevant condition to control the enabled state and hint text of the TextField.

// When isInputEnabled is true, the TextField is enabled and the user can enter text. If isInputEnabled is false, the TextField becomes disabled, and the user cannot interact with it or enter text.

// Remember to update the value of the enabled property based on your application logic and the desired interactivity of the widget.
