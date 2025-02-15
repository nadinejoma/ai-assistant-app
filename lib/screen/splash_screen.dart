import 'package:ai_assistantapp/screen/home_screen.dart';
import 'package:ai_assistantapp/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/pref.dart';
import '../widget/custom_loading.dart';

import '../helper/global.dart';
import 'onboarding_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {

    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  Pref.showOnboarding ? const OnboardingScreen(): const HomeScreen()));
      Get.off(() =>
      Pref.showOnboarding ? const OnboardingScreen() : const HomeScreen());
    } );
  }


  @override
  Widget build(BuildContext context) {
    mq= MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            const Spacer( flex : 2),
            Card(
              color: Colors.white,
              shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
              child:Padding(
                padding:  EdgeInsets.all(mq.width * .05),
                child: Image.asset('assets/images/logo.png', width: mq.width * .4 ,),
              )  ,),
            const Spacer(),

            const CustomLoading(),
            const Spacer(),
          ],
        ),
      ),
    );


  }
}
