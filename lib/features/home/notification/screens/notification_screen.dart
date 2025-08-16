import "package:flutter/material.dart";
import "package:job_app/cores/shared/app_bar_widget.dart";
import "package:job_app/features/home/notification/widget/notification_card.dart";

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            NotificationCard(
              icon: Icons.work_outline,
              title: 'Job Match',
              description:
                  'You have 5 new jobs that match your profile. Check now for the latest career opportunities.',
              time: '5 Minutes',
            ),
            NotificationCard(
              icon: Icons.email_outlined,
              title: 'Interview Invitation',
              description:
                  'Congratulations! You have been invited for an interview by Gojek. Your interview schedule is available in your calendar.',
              time: '10 Minutes',
              cardColor: Colors.white,
            ),
            NotificationCard(
              icon: Icons.bar_chart,
              title: 'Application Status',
              description:
                  'our application status has been updated. Your application for Software Engineer at Gojek is currently under review.',
              time: '1 Hour',
              cardColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
