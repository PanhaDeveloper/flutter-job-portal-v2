import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/filter_bottom_sheet.dart';
import 'package:job_app/cores/shared/label_between.dart';
import 'package:job_app/cores/shared/shimmer/shimmer.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/constants/image_strings.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';
import 'package:job_app/features/home/controller/home_controller.dart';
import 'package:job_app/features/home/widgets/card_slider.dart';
import 'package:job_app/features/home/widgets/header.dart';
import 'package:job_app/features/home/widgets/job_card.dart';
import 'package:job_app/features/home/widgets/job_category_title.dart';
import 'package:job_app/features/home/widgets/search_box.dart';
import 'package:job_app/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final responsive = AppResponsive(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsive.defaultPadding(),
                horizontal: responsive.defaultPadding(),
              ),
              child: Column(
                children: [
                  // Header with shimmer loading
                  Obx(
                    () => ShimmerHelper.wrapWithShimmer(
                      isLoading: controller.isLoadingProfile.value,
                      skeleton: ShimmerHelper.profileHeaderShimmer(),
                      child: const HeaderWidget(),
                    ),
                  ),
                  SizedBox(height: responsive.defaultPadding()),

                  // Search Box with shimmer loading
                  Obx(
                    () => ShimmerHelper.wrapWithShimmer(
                      isLoading: controller.isLoadingProfile.value,
                      skeleton: ShimmerHelper.searchBoxShimmer(),
                      child: SearchBox(
                        onPressed: () {
                          Get.bottomSheet(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            FilterBottomSheet(
                              responsive: responsive,
                              controller: controller,
                            ),
                            isScrollControlled: true,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.defaultPadding()),

                  // Label Between - Popular Jobs
                  LabelBetween(
                    title: 'popular_jobs'.tr,
                    buttonText: 'see_more'.tr,
                    onPressed: () {},
                  ),

                  // Slider with shimmer loading
                  Obx(
                    () => ShimmerHelper.wrapWithShimmer(
                      isLoading: controller.isLoadingSlider.value,
                      skeleton: ShimmerHelper.cardSliderShimmer(),
                      child: CardSlider(
                        cardDataList: [
                          CardData(
                            title: 'Creative \nVideo Editor',
                            jobText: '30+ Jobs Available',
                            backgroundImage: Images.vectorImage,
                            mainImage: Images.cameraIcon,
                            arrowIcon: Iconsax.arrow_right_2,
                            onTap: () => Get.toNamed(AppRoutes.jobDetail),
                          ),
                          CardData(
                            title: 'Creative \nVideo Editor',
                            jobText: '30+ Jobs Available',
                            backgroundImage: Images.vectorImage,
                            mainImage: Images.cameraIcon,
                            arrowIcon: Iconsax.arrow_right_2,
                            onTap: () => Get.toNamed(AppRoutes.jobDetail),
                          ),
                          CardData(
                            title: 'Creative \nVideo Editor',
                            jobText: '30+ Jobs Available',
                            backgroundImage: Images.vectorImage,
                            mainImage: Images.cameraIcon,
                            arrowIcon: Iconsax.arrow_right_2,
                            onTap: () => Get.toNamed(AppRoutes.jobDetail),
                          ),
                          CardData(
                            title: 'Creative \nVideo Editor',
                            jobText: '30+ Jobs Available',
                            backgroundImage: Images.vectorImage,
                            mainImage: Images.cameraIcon,
                            arrowIcon: Iconsax.arrow_right_2,
                            onTap: () => Get.toNamed(AppRoutes.jobDetail),
                          ),
                        ],
                      ),
                    ),
                  ), // Label Between - Latest Jobs
                  LabelBetween(
                    title: 'latest_jobs'.tr,
                    buttonText: 'see_more'.tr,
                    onPressed: () {},
                  ),
                  SizedBox(height: responsive.defaultPadding() / 2),

                  // Job Category Tabs
                  SizedBox(
                    height: responsive.isSmallDevice ? 45 : 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.tabHomeData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.defaultPadding() / 4,
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
                                  () =>
                                      controller.updateJobCategoryIndex(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: responsive.defaultPadding() / 2),

                  // Job Cards List with shimmer loading
                  Obx(
                    () => ShimmerHelper.wrapWithShimmer(
                      isLoading: controller.isLoadingJobs.value,
                      skeleton: ShimmerHelper.jobCardsHorizontalShimmer(
                        itemCount: 4,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: SizedBox(
                          key: ValueKey(controller.jobCategoryIndex.value),
                          height: responsive.isSmallDevice ? 220 : 250,
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

                              if (job.isEmpty) return const SizedBox.shrink();

                              bool isOdd = index % 2 == 1;

                              return JobCard(
                                title: job['title'],
                                salary: job['salary'],
                                jobType: job['jobType'],
                                companyName: job['companyName'],
                                companyLogo: job['companyLogo'],
                                backgroundColor:
                                    isOdd
                                        ? Colors.white
                                        : const Color.fromRGBO(0, 26, 78, 1),
                                mainTextColor:
                                    isOdd ? Colors.black : Colors.white,
                                subTextColor:
                                    isOdd
                                        ? const Color.fromARGB(169, 39, 39, 39)
                                        : const Color.fromARGB(
                                          255,
                                          210,
                                          210,
                                          210,
                                        ),
                                companyTextColor:
                                    isOdd ? Colors.black : Colors.white,
                                dotColor:
                                    isOdd
                                        ? AppColors.textPrimary
                                        : Colors.white,
                                salaryColor:
                                    isOdd ? Colors.black : Colors.white,
                                onTap: () => Get.toNamed(AppRoutes.jobDetail),
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(
                                  width: responsive.defaultPadding() / 2,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
