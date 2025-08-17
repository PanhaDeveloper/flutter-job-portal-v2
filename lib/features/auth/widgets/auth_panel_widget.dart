import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';

class AuthPanelWidget extends StatelessWidget {
  final Widget? widget;
  final Widget content;
  final double? sizeBox;
  final bool isContainer;
  final double paddingTop;
  const AuthPanelWidget({
    super.key,
    required this.content,
    this.isContainer = true,
    this.widget,
    this.sizeBox,
    this.paddingTop = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, top: paddingTop, bottom: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Khmer Career',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'From dream to career!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget ?? const SizedBox.shrink(),
                SizedBox(height: sizeBox),
                Expanded(child: SingleChildScrollView(child: content)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
