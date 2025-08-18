import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/shimmer/shimmer_widgets.dart';
import 'package:job_app/cores/shared/shimmer/job_skeletons.dart';

/// Shimmer helper class that provides easy-to-use shimmer methods
class ShimmerHelper {
  /// Creates a shimmer wrapper with smart loading detection
  static Widget wrapWithShimmer({
    required bool isLoading,
    required Widget child,
    required Widget skeleton,
    Duration fadeDuration = const Duration(milliseconds: 300),
  }) {
    return LoadingStateManager(
      isLoading: isLoading,
      shimmerWidget: skeleton,
      fadeDuration: fadeDuration,
      child: child,
    );
  }

  /// Creates a job cards grid shimmer
  static Widget jobCardsGridShimmer({int itemCount = 6}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(itemCount, (index) => const JobCardSkeleton()),
    );
  }

  /// Creates a horizontal job cards list shimmer
  static Widget jobCardsHorizontalShimmer({int itemCount = 3}) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) => const JobCardSkeleton(),
      ),
    );
  }

  /// Creates a vertical job list shimmer
  static Widget jobListShimmer({int itemCount = 5}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => const JobListItemSkeleton(),
    );
  }

  /// Creates a card slider shimmer for banners
  static Widget cardSliderShimmer() {
    return const CardSliderSkeleton();
  }

  /// Creates a profile header shimmer
  static Widget profileHeaderShimmer() {
    return const ProfileHeaderSkeleton();
  }

  /// Creates a search box shimmer
  static Widget searchBoxShimmer() {
    return const SearchBoxSkeleton();
  }

  /// Creates a custom list shimmer
  static Widget customListShimmer({
    required Widget Function(int index) skeletonBuilder,
    int itemCount = 5,
    bool shrinkWrap = true,
    ScrollPhysics? physics,
  }) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder:
          (context, index) => BaseShimmer(child: skeletonBuilder(index)),
    );
  }

  /// Creates a grid shimmer
  static Widget gridShimmer({
    required Widget Function(int index) skeletonBuilder,
    int itemCount = 6,
    int crossAxisCount = 2,
    double mainAxisSpacing = 8,
    double crossAxisSpacing = 8,
    double childAspectRatio = 1,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder:
          (context, index) => BaseShimmer(child: skeletonBuilder(index)),
    );
  }

  /// Creates a shimmer for text content with specified lines
  static Widget textContentShimmer({
    int lineCount = 3,
    double? lineHeight,
    double? spacing,
    List<double>? lineWidths,
  }) {
    return BaseShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(lineCount, (index) {
          double width =
              lineWidths != null && index < lineWidths.length
                  ? lineWidths[index]
                  : (index == lineCount - 1 ? 0.7 : 1.0);

          return Padding(
            padding: EdgeInsets.only(bottom: spacing ?? 8),
            child: FractionallySizedBox(
              widthFactor: width,
              child: ShimmerLine(
                width: double.infinity,
                height: lineHeight ?? 16,
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Creates a shimmer for card content
  static Widget cardContentShimmer({
    bool hasImage = true,
    bool hasTitle = true,
    bool hasSubtitle = true,
    bool hasDescription = true,
    bool hasButton = false,
    EdgeInsetsGeometry? padding,
  }) {
    return BaseShimmer(
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              const ShimmerBox(
                width: double.infinity,
                height: 120,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              const SizedBox(height: 12),
            ],
            if (hasTitle) ...[
              const ShimmerLine(width: double.infinity, height: 18),
              const SizedBox(height: 8),
            ],
            if (hasSubtitle) ...[
              const FractionallySizedBox(
                widthFactor: 0.7,
                child: ShimmerLine(width: double.infinity, height: 14),
              ),
              const SizedBox(height: 8),
            ],
            if (hasDescription) ...[
              const ShimmerLine(width: double.infinity, height: 12),
              const SizedBox(height: 4),
              const FractionallySizedBox(
                widthFactor: 0.9,
                child: ShimmerLine(width: double.infinity, height: 12),
              ),
              const SizedBox(height: 4),
              const FractionallySizedBox(
                widthFactor: 0.6,
                child: ShimmerLine(width: double.infinity, height: 12),
              ),
            ],
            if (hasButton) ...[
              const SizedBox(height: 16),
              const ShimmerButton(width: 120, height: 36),
            ],
          ],
        ),
      ),
    );
  }

  /// Creates a shimmer for a page with common elements
  static Widget pageShimmer({
    bool hasHeader = true,
    bool hasSearchBox = true,
    bool hasSlider = false,
    bool hasJobCards = true,
    int jobCardCount = 6,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (hasHeader) ...[
            profileHeaderShimmer(),
            const SizedBox(height: 16),
          ],
          if (hasSearchBox) ...[searchBoxShimmer(), const SizedBox(height: 16)],
          if (hasSlider) ...[cardSliderShimmer(), const SizedBox(height: 24)],
          if (hasJobCards) ...[
            jobCardsHorizontalShimmer(itemCount: jobCardCount),
          ],
        ],
      ),
    );
  }
}
