import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: mainTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(color: dotColor, fontSize: 16),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "Salary: ",
                        style: TextStyle(color: subTextColor, fontSize: 16),
                        children: [
                          TextSpan(
                            text: salary,
                            style: TextStyle(
                              color: salaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(color: dotColor, fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      jobType,
                      style: TextStyle(color: subTextColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              DottedLine(dashLength: 6, dashColor: Colors.grey),
              SizedBox(height: 12),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(companyLogo, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 10),
                  Text(
                    companyName,
                    style: TextStyle(color: companyTextColor, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
