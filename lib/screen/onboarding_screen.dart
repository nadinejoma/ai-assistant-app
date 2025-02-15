import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';
import '../model/onboard.dart';
import '../widget/custom_btn.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();
    final mq = MediaQuery.of(context).size; // MediaQuery for screen dimensions
    final PageController controller = PageController();

    final List<Onboard> list = [
      // Onboarding 1
      Onboard(
        title: 'Ask me Anything',
        subtitle:
        'I can be your Best Friend & You can ask me anything & I will help you!',
        lottie: 'ai_ask_me',
      ),
      // Onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        subtitle:
        'Just Imagine anything & let me know, I will create something wonderful for you!',
        lottie: 'ai_play',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          final isLast = index == list.length - 1;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // Lottie animation
                Lottie.asset(
                  'assets/lottie/${list[index].lottie}.json',
                  height: mq.height * 0.6,
                  width: isLast ? mq.width * .7 : null,
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  list[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Subtitle
                SizedBox(
                  width: mq.width * 0.8,
                  child: Text(
                    list[index].subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.5,
                        color: Theme.of(context).lightTextColor),
                    ),
                  ),


                const Spacer(),

                // Page indicator dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    list.length,
                        (i) => Container(
                      width: i == index ? 15 : 10,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: i == index ? Colors.purpleAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Next Button

                //button
                CustomBtn(
                    onTap: () {
                      if (isLast) {
                        Get.off(() => const HomeScreen());
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (_) => const HomeScreen()));
                      } else {
                        c.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease);
                      }
                    },
                    text: isLast ? 'Finish' : 'Next',
                  color: Colors.purpleAccent,

                ),


                const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}



