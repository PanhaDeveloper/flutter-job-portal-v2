import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:job_app/cores/shared/label_between.dart";
import "package:job_app/cores/utils/constants/colors.dart";
import "package:job_app/cores/utils/constants/image_strings.dart";
import "package:job_app/cores/utils/constants/sizes.dart";
import "package:job_app/features/home/controller/home_controller.dart";
import "package:job_app/features/home/widgets/card_slider.dart";
import "package:job_app/features/home/widgets/header.dart";
import "package:job_app/features/home/widgets/job_card.dart";
import "package:job_app/features/home/widgets/job_category_title.dart";
import "package:job_app/features/home/widgets/search_box.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                // Header
                HeaderWidget(),
                const SizedBox(height: 20),

                // Search Box
                SearchBox(),
                const SizedBox(height: 20),

                // Label Between
                LabelBetween(
                  title: "Popular Jobs",
                  buttonText: "See More",
                  onPressed: () {},
                ),

                // slider
                CardSlider(
                  cardDataList: [
                    CardData(
                      title: "Creative \nVideo Editor",
                      jobText: "30+ Jobs Available",
                      backgroundImage: Images.vectorImage,
                      mainImage: Images.cameraIcon,
                      arrowIcon: Iconsax.arrow_right_2,
                      onTap: () {},
                    ),
                    CardData(
                      title: "Creative \nVideo Editor",
                      jobText: "30+ Jobs Available",
                      backgroundImage: Images.vectorImage,
                      mainImage: Images.cameraIcon,
                      arrowIcon: Iconsax.arrow_right_2,
                      onTap: () {},
                    ),
                    CardData(
                      title: "Creative \nVideo Editor",
                      jobText: "30+ Jobs Available",
                      backgroundImage: Images.vectorImage,
                      mainImage: Images.cameraIcon,
                      arrowIcon: Iconsax.arrow_right_2,
                      onTap: () {},
                    ),
                    CardData(
                      title: "Creative \nVideo Editor",
                      jobText: "30+ Jobs Available",
                      backgroundImage: Images.vectorImage,
                      mainImage: Images.cameraIcon,
                      arrowIcon: Iconsax.arrow_right_2,
                      onTap: () {},
                    ),
                  ],
                ),

                // Label Between
                const SizedBox(height: 20),
                LabelBetween(
                  title: "Latest Jobs",
                  buttonText: "See More",
                  onPressed: () {},
                ),

                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.tabHomeData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.xs,
                        ),
                        child: Obx(
                          () => JobCategoryTitle(
                            title: controller.tabHomeData[index]['text'],
                            btnColor:
                                controller.jobCategoryIndex.value == index
                                    ? AppColors.buttonPrimary
                                    : Colors.white,
                            borderColor: AppColors.buttonPrimary,
                            textColor:
                                controller.jobCategoryIndex.value == index
                                    ? Colors.white
                                    : AppColors.buttonPrimary,
                            onPressed:
                                () => controller.updateJobCategoryIndex(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      key: ValueKey(controller.jobCategoryIndex.value),
                      height: 250,
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            controller
                                .tabHomeData[controller
                                    .jobCategoryIndex
                                    .value]['content']
                                .length,
                        itemBuilder: (context, index) {
                          var job =
                              controller.tabHomeData[controller
                                  .jobCategoryIndex
                                  .value]['content'][index];

                          return controller
                                  .tabHomeData[controller
                                      .jobCategoryIndex
                                      .value]['content'][index]
                                  .isNotEmpty
                              ? JobCard(
                                title: job['title'],
                                salary: job['salary'],
                                jobType: job['jobType'],
                                companyName: job['companyName'],
                                companyLogo: job['companyLogo'],
                                companyTextColor:
                                    index % 2 == 1
                                        ? Colors.black
                                        : Colors.white,
                                salaryColor:
                                    index % 2 == 1
                                        ? Colors.black
                                        : Colors.white,
                                dotColor:
                                    index % 2 == 1
                                        ? AppColors.textPrimary
                                        : Colors.white,
                                subTextColor:
                                    index % 2 == 1
                                        ? const Color.fromARGB(169, 39, 39, 39)
                                        : const Color.fromARGB(
                                          255,
                                          210,
                                          210,
                                          210,
                                        ),
                                mainTextColor:
                                    index % 2 == 1
                                        ? Colors.black
                                        : Colors.white,
                                backgroundColor:
                                    index % 2 == 1
                                        ? Colors.white
                                        : const Color.fromRGBO(0, 26, 78, 1),
                              )
                              : const SizedBox.shrink();
                        },
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
