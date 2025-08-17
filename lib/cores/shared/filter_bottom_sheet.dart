import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_app/cores/shared/button_widget.dart';
import 'package:job_app/cores/shared/custom_text_field.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';
import 'package:job_app/features/home/controller/home_controller.dart';
import 'package:job_app/features/home/widgets/choice_chip_widget.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
    required this.responsive,
    required this.controller,
  });

  final AppResponsive responsive;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsive.isSmallDevice ? 400 : 500,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Location
              const Text(
                'Job Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: controller.jobLocation.value,
                prefixIcon: const Icon(Iconsax.location),
              ),
              const SizedBox(height: 20),

              // Work Interest
              const Text(
                'Work Interest',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: controller.workInterest.value,
                prefixIcon: const Icon(Iconsax.wallet),
              ),
              const SizedBox(height: 20),

              // Role Chips
              SizedBox(
                height: 40,
                child: ChoiceChipWidget(controller: controller),
              ),
              const SizedBox(height: 20),

              // Salary Range
              const Text(
                'Salary Range',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              // Range Slider
              RangeSlider(
                values: controller.salaryRange.value,
                min: 0,
                max: 1000,
                divisions: 20,
                activeColor: Colors.blue,
                labels: RangeLabels(
                  '\$${controller.salaryRange.value.start.toInt()}',
                  '\$${controller.salaryRange.value.end.toInt()}',
                ),
                onChanged: (RangeValues values) {
                  controller.salaryRange.value = values;
                },
              ),

              // Display Salary Range
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${controller.salaryRange.value.start.toInt()}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  Text(
                    '\$${controller.salaryRange.value.end.toInt()}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Categories
              const Text(
                'Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children:
                    controller.categories.keys.map((key) {
                      return CheckboxListTile(
                        value: controller.categories[key],
                        onChanged: (val) {
                          controller.categories[key] = val!;
                        },
                        title: Text(key),
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),

              // Apply Button
              ButtonWidget(
                width: double.infinity,
                height: 50,
                btnTitle: 'Apply Filters',
                borderRadius: 15,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
