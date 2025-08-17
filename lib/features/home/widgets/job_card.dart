import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String salary;
  final String jobType;
  final String companyName;
  final String companyLogo;
  final Color backgroundColor;
  final Color mainTextColor;
  final Color dotColor;
  final Color subTextColor;
  final Color companyTextColor;
  final Color salaryColor;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.title,
    required this.salary,
    required this.jobType,
    required this.companyName,
    required this.companyLogo,
    this.backgroundColor = const Color.fromRGBO(0, 26, 78, 1),
    this.mainTextColor = AppColors.textPrimary,
    this.dotColor = Colors.white,
    this.subTextColor = const Color.fromARGB(255, 210, 210, 210),
    this.companyTextColor = Colors.white,
    this.salaryColor = AppColors.textPrimary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = AppResponsive(context);

    double cardWidth =
        responsive.isSmallDevice
            ? 180
            : responsive.isMediumDevice
            ? 200
            : 220;

    double cardHeight =
        responsive.isSmallDevice
            ? 180
            : responsive.isMediumDevice
            ? 200
            : 220;

    double padding =
        responsive.isSmallDevice
            ? 12
            : responsive.isMediumDevice
            ? 20
            : 24;

    double titleFontSize =
        responsive.isSmallDevice
            ? 16
            : responsive.isMediumDevice
            ? 18
            : 20;

    double subFontSize =
        responsive.isSmallDevice
            ? 12
            : responsive.isMediumDevice
            ? 14
            : 16;

    double borderRadius =
        responsive.isSmallDevice
            ? 15
            : responsive.isMediumDevice
            ? 18
            : 20;

    double spacingSmall =
        responsive.isSmallDevice
            ? 4
            : responsive.isMediumDevice
            ? 5
            : 6;

    double spacingMedium =
        responsive.isSmallDevice
            ? 8
            : responsive.isMediumDevice
            ? 10
            : 12;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: const BorderSide(
            color: Color.fromARGB(255, 245, 245, 245),
            width: 1,
          ),
        ),
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Flexible(
                  flex: 2,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: mainTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: spacingSmall),

                // Details section
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022 ',
                            style: TextStyle(
                              color: dotColor,
                              fontSize: subFontSize,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Salary: ',
                                style: TextStyle(
                                  color: subTextColor,
                                  fontSize: subFontSize,
                                ),
                                children: [
                                  TextSpan(
                                    text: salary,
                                    style: TextStyle(
                                      color: salaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: subFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacingSmall),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022 ',
                            style: TextStyle(
                              color: dotColor,
                              fontSize: subFontSize,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              jobType,
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: subFontSize,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(height: spacingMedium),
                      const DottedLine(
                        dashLength: 6,
                        dashColor: Colors.grey,
                        lineThickness: 1,
                      ),
                    ],
                  ),
                ),

                // Company section
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius / 4),
                        child: Image.asset(
                          companyLogo,
                          width:
                              responsive.isSmallDevice
                                  ? 25
                                  : responsive.isMediumDevice
                                  ? 30
                                  : 35,
                          height:
                              responsive.isSmallDevice
                                  ? 25
                                  : responsive.isMediumDevice
                                  ? 30
                                  : 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spacingSmall),
                      Expanded(
                        child: Text(
                          companyName,
                          style: TextStyle(
                            color: companyTextColor,
                            fontSize: subFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
