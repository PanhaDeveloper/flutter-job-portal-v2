import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/shimmer/shimmer_widgets.dart';
import 'package:job_app/cores/utils/helpers/app_resposive.dart';

/// Job card skeleton that matches the structure of JobCard
class JobCardSkeleton extends StatelessWidget {
  const JobCardSkeleton({super.key});

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

    double borderRadius =
        responsive.isSmallDevice
            ? 15
            : responsive.isMediumDevice
            ? 18
            : 20;

    return Card(
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
              // Title skeleton (2 lines)
              const ShimmerLine(width: double.infinity, height: 16),
              const SizedBox(height: 4),
              ShimmerLine(width: cardWidth * 0.7, height: 16),
              const SizedBox(height: 12),

              // Salary line skeleton
              Row(
                children: [
                  const ShimmerCircle(diameter: 6),
                  const SizedBox(width: 8),
                  ShimmerLine(width: cardWidth * 0.6, height: 12),
                ],
              ),
              const SizedBox(height: 8),

              // Job type line skeleton
              Row(
                children: [
                  const ShimmerCircle(diameter: 6),
                  const SizedBox(width: 8),
                  ShimmerLine(width: cardWidth * 0.5, height: 12),
                ],
              ),
              const SizedBox(height: 16),

              // Divider line
              const ShimmerLine(
                width: double.infinity,
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 8),
              ),

              const Spacer(),

              // Company section skeleton
              Row(
                children: [
                  ShimmerBox(
                    width: responsive.isSmallDevice ? 25 : 35,
                    height: responsive.isSmallDevice ? 25 : 35,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  const SizedBox(width: 8),
                  ShimmerLine(width: cardWidth * 0.5, height: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card slider skeleton for the banner section
class CardSliderSkeleton extends StatelessWidget {
  const CardSliderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = AppResponsive(context);

    return Column(
      children: [
        // Main card skeleton
        Container(
          width: double.infinity,
          height: responsive.cardHeight(),
          margin: EdgeInsets.symmetric(
            vertical: responsive.isSmallDevice ? 10 : 20,
            horizontal: responsive.isSmallDevice ? 5 : 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(
              responsive.isSmallDevice ? 12 : 20,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Left content
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title lines
                      const ShimmerLine(width: double.infinity, height: 20),
                      const SizedBox(height: 8),
                      ShimmerLine(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 20,
                      ),
                      const SizedBox(height: 20),

                      // Button skeleton
                      const ShimmerButton(
                        width: 140,
                        height: 35,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Right image placeholder
                Expanded(
                  flex: 1,
                  child: ShimmerBox(
                    width: 100,
                    height: responsive.cardHeight() * 0.6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Dot indicators skeleton
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// List item skeleton for job lists and favorites
class JobListItemSkeleton extends StatelessWidget {
  const JobListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 245, 245, 245)),
      ),
      child: ListTile(
        leading: const ShimmerBox(
          width: 50,
          height: 50,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLine(width: double.infinity, height: 16),
            const SizedBox(height: 4),
            ShimmerLine(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 14,
            ),
            const SizedBox(height: 8),
            ShimmerLine(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 12,
            ),
          ],
        ),
        trailing: const ShimmerBox(
          width: 24,
          height: 24,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}

/// Profile header skeleton
class ProfileHeaderSkeleton extends StatelessWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile image
        const ShimmerCircle(diameter: 50),
        const SizedBox(width: 12),

        // Profile info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerLine(width: double.infinity, height: 14),
              const SizedBox(height: 4),
              ShimmerLine(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 18,
              ),
            ],
          ),
        ),

        // Action buttons
        const Row(
          children: [
            ShimmerBox(
              width: 32,
              height: 32,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            SizedBox(width: 8),
            ShimmerBox(
              width: 32,
              height: 32,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ],
        ),
      ],
    );
  }
}

/// Search box skeleton
class SearchBoxSkeleton extends StatelessWidget {
  const SearchBoxSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Row(
        children: [
          ShimmerBox(width: 20, height: 20),
          SizedBox(width: 12),
          Expanded(child: ShimmerLine(width: double.infinity, height: 16)),
          SizedBox(width: 12),
          ShimmerBox(width: 20, height: 20),
        ],
      ),
    );
  }
}

/// Generic content skeleton for pages
class ContentSkeleton extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) skeletonBuilder;

  const ContentSkeleton({
    super.key,
    this.itemCount = 5,
    required this.skeletonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: skeletonBuilder(index),
        ),
      ),
    );
  }
}
