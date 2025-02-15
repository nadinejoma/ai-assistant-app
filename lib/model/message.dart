import 'package:flutter/material.dart';

// Enum for message types (User or Bot)
enum MessageType {
  user,  // User messages
  bot,   // Bot messages
}

class Message {
  final String msg;          // The message content (text)
  final MessageType msgType; // The type of message (user or bot)
  final String? imageUrl;    // The image URL, can be null for text messages

  // Constructor for the Message class
  Message({
    required this.msg,       // Message content (text)
    required this.msgType,   // Message type (user or bot)
    this.imageUrl,           // Optional image URL
  });
}

