import 'package:flutter/material.dart';
import 'package:quiz_app/cores/utils/constants/colors.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final bool isBorderBottom;
  final Color cardColor;
  final Color timeColor;
  final Color borderColor;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    this.isBorderBottom = false,
    this.cardColor = const Color.fromARGB(146, 216, 229, 248),
    this.timeColor = AppColors.boldPrimary,
    this.borderColor = const Color.fromARGB(255, 227, 232, 240), this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1.0)),
        ),
        child: Card(
          elevation: 0,
          color: cardColor,
          margin: EdgeInsets.only(bottom: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            // side: BorderSide(color: Colors.grey, width: 1.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  minRadius: 15,
                  backgroundColor: AppColors.boldPrimary.withOpacity(0.1),
                  child: Icon(icon, color: AppColors.boldPrimary, size: 18),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(31, 44, 52, 1),
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(fontSize: 12.0, color: timeColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.textSecondary,
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