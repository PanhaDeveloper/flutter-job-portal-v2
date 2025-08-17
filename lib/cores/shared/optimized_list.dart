import 'package:flutter/material.dart';

class OptimizedListView extends StatelessWidget {
  const OptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.controller,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.separatorBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final double? cacheExtent;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    if (separatorBuilder != null) {
      return ListView.separated(
        itemCount: itemCount,
        itemBuilder: _wrappedItemBuilder,
        separatorBuilder: separatorBuilder!,
        scrollDirection: scrollDirection,
        physics: physics ?? const BouncingScrollPhysics(),
        controller: controller,
        padding: padding,
        cacheExtent: cacheExtent ?? 500,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: false,
      );
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: _wrappedItemBuilder,
      itemExtent: itemExtent,
      scrollDirection: scrollDirection,
      physics: physics ?? const BouncingScrollPhysics(),
      controller: controller,
      padding: padding,
      cacheExtent: cacheExtent ?? 500,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: false,
    );
  }

  Widget _wrappedItemBuilder(BuildContext context, int index) {
    return RepaintBoundary(
      child: AutomaticKeepAlive(child: itemBuilder(context, index)),
    );
  }
}

class OptimizedGridView extends StatelessWidget {
  const OptimizedGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.physics,
    this.controller,
    this.padding,
    this.cacheExtent,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final double? cacheExtent;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      itemBuilder: _wrappedItemBuilder,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      physics: physics ?? const BouncingScrollPhysics(),
      controller: controller,
      padding: padding,
      cacheExtent: cacheExtent ?? 500,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: false,
    );
  }

  Widget _wrappedItemBuilder(BuildContext context, int index) {
    return RepaintBoundary(child: itemBuilder(context, index));
  }
}

class OptimizedSliverList extends StatelessWidget {
  const OptimizedSliverList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemExtent,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double? itemExtent;

  @override
  Widget build(BuildContext context) {
    if (itemExtent != null) {
      return SliverFixedExtentList(
        itemExtent: itemExtent!,
        delegate: SliverChildBuilderDelegate(
          _wrappedItemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          addSemanticIndexes: false,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _wrappedItemBuilder,
        childCount: itemCount,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: false,
      ),
    );
  }

  Widget _wrappedItemBuilder(BuildContext context, int index) {
    return RepaintBoundary(child: itemBuilder(context, index));
  }
}
