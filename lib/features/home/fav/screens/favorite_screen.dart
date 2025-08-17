import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/shared/filter_bottom_sheet.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';
import 'package:job_app/features/home/controller/home_controller.dart';
import 'package:job_app/features/home/widgets/search_box.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final responsive = AppResponsive(context);

    return Scaffold(
      appBar: AppBarWidget(title: 'favorites'.tr, isLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: [
            SearchBox(
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) => const JobListTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobListTile extends StatelessWidget {
  const JobListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: ListTile(
        leading: const Icon(Icons.business, color: Colors.blue, size: 50),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gojek', style: TextStyle(color: AppColors.textSecondary)),
            Text('Software Engineer'),
          ],
        ),
        subtitle: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$3000 - ', style: TextStyle(color: AppColors.textSecondary)),
            Text('Gojek', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: AppColors.boldPrimary),
          onPressed: () {},
        ),
        onTap: () {},
      ),
    );
  }
}
