import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../helper/global.dart';
import '../model/message.dart';
import '../main.dart'; // Ensure `mq` is defined in your `main.dart`.

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(15);

    // Check if the message has an image URL
    if (message.imageUrl != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 6),
          if (message.msgType == MessageType.bot)
            CircleAvatar(
              child: Image.asset('assets/images/logo.png', width: 24),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: mq.width * .8),
            margin: EdgeInsets.only(
              bottom: mq.height * .02,
              left: message.msgType == MessageType.bot ? mq.width * .02 : 0,
              right: message.msgType == MessageType.user ? mq.width * .02 : 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                message.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }

    // Bot Message Layout (No Image)
    if (message.msgType == MessageType.bot) {
      return Row(
        children: [
          const SizedBox(width: 6),
          CircleAvatar(
            child: Image.asset('assets/images/logo.png', width: 24),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: mq.width * .6),
            margin: EdgeInsets.only(
              bottom: mq.height * .02,
              right: mq.width * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: mq.height * .01,
              horizontal: mq.width * .02,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).lightTextColor),
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomRight: radius,
              ),
            ),
            child: message.msg.isEmpty
                ? AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  ' Please Wait.. ',
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              repeatForever: true,
            )
                : Text(
              message.msg,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    // User Message Layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: mq.width * .6),
          margin: EdgeInsets.only(
            bottom: mq.height * .02,
            left: mq.width * .02,
          ),
          padding: EdgeInsets.symmetric(
            vertical: mq.height * .01,
            horizontal: mq.width * .02,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).lightTextColor),
            borderRadius: const BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: radius,
            ),
          ),
          child: Text(
            message.msg,
            textAlign: TextAlign.center,
          ),
        ),
        const CircleAvatar(
          child: Icon(Icons.person, color: Colors.purpleAccent),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}
