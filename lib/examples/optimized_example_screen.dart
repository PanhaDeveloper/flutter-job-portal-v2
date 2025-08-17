import 'package:flutter/material.dart';
import 'package:job_app/cores/shared/optimized_image.dart';
import 'package:job_app/cores/shared/optimized_list.dart';
import 'package:job_app/cores/shared/optimized_button.dart';
import 'package:job_app/cores/shared/smooth_loading.dart';
import 'package:job_app/cores/utils/animations/smooth_animations.dart';

/// Example of how to use the performance-optimized widgets
class OptimizedExampleScreen extends StatefulWidget {
  const OptimizedExampleScreen({super.key});

  @override
  State<OptimizedExampleScreen> createState() => _OptimizedExampleScreenState();
}

class _OptimizedExampleScreenState extends State<OptimizedExampleScreen> {
  bool isLoading = false;
  final List<String> items = List.generate(100, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Optimized Example'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SmoothLoadingOverlay(
        isLoading: isLoading,
        child: Column(
          children: [
            // Optimized image with smooth fade-in
            OptimizedAssetImage(
              assetPath: 'assets/logo/app_logo.png',
              width: 200,
              height: 100,
              borderRadius: BorderRadius.circular(12),
            ).smoothFadeIn(),

            const SizedBox(height: 16),

            // Optimized buttons with haptic feedback
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OptimizedButton(
                      onPressed: _simulateLoading,
                      isLoading: isLoading,
                      child: const Text('Start Loading'),
                    ).smoothSlideIn(offset: const Offset(-0.1, 0)),
                  ),
                  const SizedBox(width: 12),
                  OptimizedIconButton(
                    onPressed: _refresh,
                    icon: Icons.refresh,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.1),
                    color: Theme.of(context).primaryColor,
                  ).smoothScale(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Optimized list with smooth item animations
            Expanded(
              child: OptimizedListView(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return SmoothListItemAnimation(
                    index: index,
                    child: _buildListItem(items[index], index),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 1);
                },
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OptimizedFloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ).smoothFadeIn(duration: const Duration(milliseconds: 500)),
    );
  }

  Widget _buildListItem(String item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: OptimizedAssetImage(
          assetPath: 'assets/general/profile.png',
          width: 40,
          height: 40,
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Description for $item'),
        trailing: OptimizedIconButton(
          onPressed: () => _removeItem(index),
          icon: Icons.delete_outline,
          color: Colors.red,
        ),
        onTap: () => _showItemDetails(item),
      ),
    );
  }

  void _simulateLoading() async {
    setState(() {
      isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    _showSnackBar('Loading completed!');
  }

  void _refresh() {
    _showSnackBar('Refreshed!');
  }

  void _addItem() {
    setState(() {
      items.add('Item ${items.length}');
    });
    _showSnackBar('Item added!');
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    _showSnackBar('Item removed!');
  }

  void _showItemDetails(String item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(item),
            content:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OptimizedAssetImage(
                      assetPath: 'assets/general/profile.png',
                      width: 80,
                      height: 80,
                      borderRadius: BorderRadius.circular(40),
                    ).smoothFadeIn(),
                    const SizedBox(height: 16),
                    Text('Details for $item'),
                  ],
                ).smoothSlideIn(),
            actions: [
              OptimizedButton(
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

/// Example showing shimmer loading placeholders
class ShimmerExampleScreen extends StatelessWidget {
  const ShimmerExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shimmer Loading Example')),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const ShimmerPlaceholder(
                    width: 60,
                    height: 60,
                    borderRadius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerPlaceholder(
                          width: double.infinity,
                          height: 16,
                          borderRadius: 4,
                        ),
                        const SizedBox(height: 8),
                        ShimmerPlaceholder(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 14,
                          borderRadius: 4,
                        ),
                        const SizedBox(height: 8),
                        ShimmerPlaceholder(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 12,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
