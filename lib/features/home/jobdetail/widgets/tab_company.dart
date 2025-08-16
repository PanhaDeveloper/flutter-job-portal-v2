import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/text_box_container.dart';

class TabCompany extends StatelessWidget {
  const TabCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxContainer(
          textTitle: 'About the Company',
          isBullet: false,
          bulletPoints: [
            'Gojek is a leading technology company in Southeast Asia.',
            'We provide a wide range of services including ride-hailing, food delivery, and digital payments.',
            'Our mission is to empower people through technology and innovation.',
            'We are committed to creating a positive impact in the communities we serve.',
            'Join us in our journey to transform the way people live and work in Southeast Asia.',
          ],
        ),
      ],
    );
  }
}
