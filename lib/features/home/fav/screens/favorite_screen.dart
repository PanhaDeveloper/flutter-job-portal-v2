import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/app_bar_widget.dart';
import 'package:job_app/cores/utils/constants/colors.dart';
import 'package:job_app/features/home/widgets/search_box.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Favorites', isLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: [
            const SearchBox(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) => const JobListTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobListTile extends StatelessWidget {
  const JobListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.business, color: Colors.blue, size: 50),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gojek', style: TextStyle(color: AppColors.textSecondary)),
            Text('Software Engineer'),
          ],
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$3000 - ', style: TextStyle(color: AppColors.textSecondary)),
            Text('Gojek', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: AppColors.boldPrimary),
          onPressed: () {},
        ),
        onTap: () {},
      ),
    );
  }
}
