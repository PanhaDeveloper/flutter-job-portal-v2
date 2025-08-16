import 'package:flutter/material.dart';
import 'package:job_app/features/home/fav/screens/favorite_screen.dart';

class RecentlyWidget extends StatelessWidget {
  const RecentlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 2 / 2.8,
      child: ListView.separated(
        itemCount: 8,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => const JobListTile(),
      ),
    );
  }
}
