import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/image_controller.dart';
import '../../helper/global.dart';
import '../../widget/custom_btn.dart';
import '../../widget/custom_loading.dart';
class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = ImageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('AI Image Creator'),),
        body: ListView(
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .01, left: mq.width * .04, right: mq.width * .04 ),
          children: [TextFormField(
            controller: _c.textC,
          textAlign: TextAlign.center,
          minLines: 2,
          maxLines: null,
          onTapOutside: (e)=>FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(

              hintText: 'Imagine something wonderful & innovative \n  Type here & I will create an image for You 🔥 ',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
            //ai image
            Container(
                height: mq.height * .5,
                margin: EdgeInsets.symmetric(vertical: mq.height * .015),
                alignment: Alignment.center,
                child: Obx(() => _aiImage())),

            Obx(() => _c.imageList.isEmpty
                ? const SizedBox()
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: mq.height * .03),
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 10,
                children: _c.imageList
                    .map((e) => InkWell(
                  onTap: () {
                    _c.url.value = e;
                  },
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: e,
                      height: 100,
                      errorWidget: (context, url, error) =>
                      const SizedBox(),
                    ),
                  ),
                ))
                    .toList(),
              ),
            )),

            //create btn
            // CustomBtn(onTap: _c.createAIImage, text: 'Create'),
            CustomBtn(onTap: _c.searchAiImage, text: 'Create'),
          ],
        ),
    );
  }

  Widget _aiImage() => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: switch (_c.status.value) {
      Status.none =>
          Lottie.asset('assets/lottie/ai_play.json', height: mq.height * .3),
      Status.complete => CachedNetworkImage(
        imageUrl: _c.url.value,
        placeholder: (context, url) => const CustomLoading(),
        errorWidget: (context, url, error) => const SizedBox(),
      ),
      Status.loading => const CustomLoading()
    },
  );
}