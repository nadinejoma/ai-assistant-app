import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/chat_controller.dart';
import '../../widget/message_card.dart';
import '../../helper/global.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final ChatController _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat With AI Assistant'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.center,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  isDense: true,
                  hintText: 'Ask Me Anything You Want...',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              radius: 24,
              child: IconButton(
                onPressed: _c.askQuestion,
                icon: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
            () => ListView(
          physics: const BouncingScrollPhysics(),
          controller: _c.scrollC,
          padding: EdgeInsets.only(
            top: mq.height * .02,
            bottom: mq.height * .01,
          ),
          children: _c.list.map((e) {
            return e.imageUrl != null
                ? Image.network(e.imageUrl!, fit: BoxFit.cover) // Display the image if available
                : MessageCard(message: e); // Display message card if no image
          }).toList(),
        ),
      ),
    );
  }
}



