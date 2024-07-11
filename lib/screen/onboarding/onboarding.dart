import 'package:flutter/material.dart';
import 'package:onboarding_page/screen/onboarding/item/onboarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItem();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: Container(
          height: 90,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: isLastPage
              ? getStarted()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => pageController
                            .jumpToPage(controller.items.length - 1),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Skip',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 215, 69),
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 255, 215, 69),
                                  decorationThickness: 2)),
                        )),

                    // Indicator
                    SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      effect: const WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor: Color.fromARGB(255, 255, 215, 69)),
                    ),

                    TextButton(
                        onPressed: () => pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn,
                            ),
                        child: const Text('Next',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 215, 69),
                                fontSize: 16))),
                  ],
                ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == (index)),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    controller.items[index].descriptions,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 186, 186, 186),
                        fontSize: 14,
                        height: 1.20),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          ),
        ));
  }

  // Get started button

  Widget getStarted() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 255, 215, 69)),
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        child: TextButton(
            onPressed: () {},
            child: const Text(
              "Get Started",
              style: TextStyle(
                  color: Colors.white, fontSize: 16, letterSpacing: 1.5),
            )));
  }
}
