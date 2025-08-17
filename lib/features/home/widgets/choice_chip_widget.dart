import 'package:flutter/material.dart';
import 'package:job_app/features/home/controller/home_controller.dart';

class ChoiceChipWidget extends StatelessWidget {
  const ChoiceChipWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children:
          [
            'UI Designer',
            'UX Researcher',
            '3D Designer',
            'Graphic Designer',
          ].map((role) {
            final isSelected = controller.selectedRoles.contains(role);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(role),
                selected: isSelected,
                selectedColor: Colors.blue,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                onSelected: (selected) {
                  if (selected) {
                    controller.selectedRoles.add(role);
                  } else {
                    controller.selectedRoles.remove(role);
                  }
                },
              ),
            );
          }).toList(),
    );
  }
}
