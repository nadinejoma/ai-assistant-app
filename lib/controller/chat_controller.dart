import 'dart:math'; // For randomization
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:audioplayers/audioplayers.dart'; // Import audioplayers package
import '../model/message.dart';
import '../apis/apis.dart';
import '../helper/my_dialog.dart';

class ChatController extends GetxController {
  final textC = TextEditingController(); // Text controller for the input field
  final scrollC = ScrollController(); // Scroll controller to control chat scroll
  final list = <Message>[
    Message(msg: 'Hello, How can I help you?', msgType: MessageType.bot)
  ].obs; // List of messages, starts with a greeting message

  late final AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer at declaration

  // Function to handle user input and generate response
  Future<void> askQuestion() async {
    final input = textC.text.trim(); // Get the input text
    if (input.isNotEmpty) {
      // Add user message to the chat list
      list.add(Message(msg: input, msgType: MessageType.user));
      list.add(Message(msg: '', msgType: MessageType.bot)); // Placeholder for bot response
      _scrollDown(); // Scroll to the bottom

      try {
        // Analyze the sentiment of the input text
        final score = await APIs.analyzeSentiment(input);
        dev.log('Sentiment score: $score'); // Log sentiment score

        // Fetch response from Google Gemini AI (for general responses)
        String responseFromAI = await APIs.getAnswer(input); // Call the API method here

        // Display response from AI if no calming image or audio is required
        list.removeLast(); // Remove the placeholder message
        list.add(Message(
          msg: responseFromAI,
          msgType: MessageType.bot,
        ));
        _scrollDown();

        // If the sentiment is negative (stress detected), show a random image and play audio
        if (score < 0) {
          dev.log('Stress detected: Playing calming audio'); // Log when stress is detected
          list.add(Message(
            msg: 'It seems like you’re stressed. Let me calm you.',
            msgType: MessageType.bot,
          ));
          _scrollDown();

          // Generate and display a random calming image
          final images = await APIs.searchAiImages('calming nature scene');
          if (images.isNotEmpty) {
            final randomImage = images[Random().nextInt(images.length)];
            list.add(Message(
              msg: '',
              msgType: MessageType.bot,
              imageUrl: randomImage, // Display a random image
            ));
          } else {
            list.add(Message(
              msg: 'I couldn’t find a calming image for you. Please try again later.',
              msgType: MessageType.bot,
            ));
          }

          // Play a random calming audio
          await _playCalmingAudio();
        }
      } catch (e) {
        // Handle errors from sentiment analysis
        list.removeLast();
        list.add(Message(
          msg: 'Something went wrong while analyzing your input. Please try again.',
          msgType: MessageType.bot,
        ));
      }

      _scrollDown(); // Scroll to the bottom again after response
      textC.clear(); // Clear the input field
    } else {
      MyDialog.info('Please type a message.'); // Show a message if input is empty
    }
  }

  // Function to ensure scrolling only happens when the ListView is ready
  void _scrollDown() {
    // Check if the ListView controller is attached
    if (scrollC.hasClients) {
      // Scroll to the bottom only if the ListView is available
      scrollC.animateTo(
        scrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      dev.log('ScrollController not attached');
    }
  }

  // Function to play a random calming audio
  Future<void> _playCalmingAudio() async {
    final audioFiles = [
      'audio/relax_audio1.mp3',
      'audio/relax_audio2.mp3',
    ];

    try {
      // Log available audio files
      dev.log('Audio files available: $audioFiles');

      // Select a random audio file
      final randomIndex = Random().nextInt(audioFiles.length);
      final randomAudio = audioFiles[randomIndex];

      dev.log('Playing audio file: $randomAudio');

      // Attempt to play the selected audio file
      await _audioPlayer.play(AssetSource(randomAudio));
    } catch (e) {
      dev.log('Error playing audio: $e');
    }
  }

  // Dispose the audio player when the controller is destroyed
  @override
  void onClose() {
    _audioPlayer.dispose(); // Dispose of the audio player
    super.onClose();
  }
}











