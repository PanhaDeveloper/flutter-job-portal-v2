import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/build_dot_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';
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
    final responsive = AppResponsive(context);

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller.carouselController,
          itemCount: cardDataList.length,
          options: CarouselOptions(
            height: responsive.cardHeight(),
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
              padding: EdgeInsets.symmetric(
                vertical: responsive.isSmallDevice ? 10 : 20,
                horizontal: responsive.isSmallDevice ? 5 : 10,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimary,
                  borderRadius: BorderRadius.circular(
                    responsive.isSmallDevice ? 12 : 20,
                  ),
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
                        padding: EdgeInsets.only(
                          left: responsive.isSmallDevice ? 10 : 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.titleFontSize(),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: responsive.isSmallDevice ? 8 : 15),
                            InkWell(
                              onTap: data.onTap,
                              borderRadius: BorderRadius.circular(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            responsive.isSmallDevice ? 4 : 10,
                                        vertical:
                                            responsive.isSmallDevice ? 2 : 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      child: Text(
                                        data.jobText,
                                        style: TextStyle(
                                          fontSize: responsive.jobFontSize(),
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    data.arrowIcon,
                                    color: Colors.white,
                                    size: responsive.isSmallDevice ? 16 : 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        data.mainImage,
                        height: responsive.cardHeight() * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
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
