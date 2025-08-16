import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/build_dot_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/home/controller/home_controller.dart';

class CardData {
  final String title;
  final String jobText;
  final String backgroundImage;
  final String mainImage;
  final IconData arrowIcon;
  final VoidCallback onTap;

  CardData({
    required this.title,
    required this.jobText,
    required this.backgroundImage,
    required this.mainImage,
    required this.arrowIcon,
    required this.onTap,
  });
}

class CardSlider extends StatelessWidget {
  final List<CardData> cardDataList;
  final controller = HomeController.instance;

  CardSlider({super.key, required this.cardDataList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller.carouselController,
          itemCount: cardDataList.length,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged:
                (index, reason) => controller.updateSlideIndex(index),
          ),
          itemBuilder: (context, index, realIndex) {
            final data = cardDataList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimary,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(data.backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width < 321 ? 20.0 : 25.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            InkWell(
                              onTap: data.onTap,
                              borderRadius: BorderRadius.circular(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width < 321 ? 1 : 10,
                                        vertical: size.width < 321 ? 2 : 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      child: Text(
                                        data.jobText,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    data.arrowIcon,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(data.mainImage, fit: BoxFit.cover),
                  ],
                ),
              ),
            );
          },
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              cardDataList.length,
              (index) => BuildDotWidget(
                index: index,
                currentIndex: controller.slideCurrentIndex.value,
                onTap: () => controller.moveCarouselBaseOnDotClicked(index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
