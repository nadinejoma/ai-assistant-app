import 'dart:developer';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import '../helper/my_dialog.dart';


import '../apis/apis.dart';
import '../helper/global.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  final url = ''.obs;

  final imageList = <String>[].obs;


  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      OpenAI.apiKey = apiKey;
      status.value = Status.loading;

      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: textC.text,
        n: 1,
        size: OpenAIImageSize.size512,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      url.value = image.data[0].url.toString();


      status.value = Status.complete;

    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }


  Future<void> searchAiImage() async {
    //if prompt is not empty
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;

      imageList.value = await APIs.searchAiImages(textC.text);

      if (imageList.isEmpty) {
        MyDialog.error('Something went wrong (Try again in sometime)');

        return;
      }

      url.value = imageList.first;

      status.value = Status.complete;
    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }
}


