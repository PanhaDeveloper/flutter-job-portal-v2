import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/text_box_container.dart';

class TabDescription extends StatelessWidget {
  const TabDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBoxContainer(
          textTitle: 'Qualifications',
          isBullet: true,
          bulletPoints: [
            'Strong portfolio to be presented.',
            'Minimum 2-3 years Experience needed.',
            'Able to study a problem with systematic techniques and frameworks.',
          ],
        ),
        SizedBox(height: 20),
        TextBoxContainer(
          textTitle: 'Responsibilities',
          isBullet: false,
          bulletPoints: [
            'Strong portfolio to be presented.',
            'Minimum 2-3 years Experience needed.',
            'Able to study a problem with systematic techniques and frameworks.',
            'Develop and maintain software applications.',
            'Collaborate with cross-functional teams.',
            'Participate in code reviews and maintain code quality.',
            'Stay updated with the latest industry trends.',
          ],
        ),
      ],
    );
  }
}
