import 'package:flutter/material.dart';

class CustomShimmerLoader extends StatefulWidget {
  final int itemCount;

  const CustomShimmerLoader({Key? key, required this.itemCount}) : super(key: key);

  @override
  State<CustomShimmerLoader> createState() => _CustomShimmerLoaderState();
}

class _CustomShimmerLoaderState extends State<CustomShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 226,
          crossAxisSpacing: 15,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: GridTile(
                child: ShimmerLoader(
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
              ),
            );
          },
          childCount: widget.itemCount,
        ),
      ),
    );
  }
}

class Shimmer extends StatelessWidget {
  final Widget child;

  const Shimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: child,
        );
      },
    );
  }
}
class ShimmerLoader extends StatefulWidget {
  final Widget child;
  const ShimmerLoader({super.key, required this.child});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> with SingleTickerProviderStateMixin{
  late final controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
    lowerBound: 0.5,
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
      controller.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Shimmer(child: widget.child),
    );
  }
}

class FavFolderShimmerLoader extends StatefulWidget {

  const FavFolderShimmerLoader({Key? key}) : super(key: key);

  @override
  State<FavFolderShimmerLoader> createState() => _FavFolderShimmerLoaderState();
}

class _FavFolderShimmerLoaderState extends State<FavFolderShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 35,
          right: 34,
          top: 70,
          bottom: 30,
        ),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 145,
            crossAxisSpacing: 34,
            mainAxisSpacing: 34,
          ),
          children: List.generate(4, (index) => ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: GridTile(
                child: ShimmerLoader(
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
              ),
          )
          ),
        ),
      ),
    );
  }
}

class WardrobeColorShimmerLoader extends StatefulWidget {

  const WardrobeColorShimmerLoader({Key? key}) : super(key: key);

  @override
  State<WardrobeColorShimmerLoader> createState() => _WardrobeColorShimmerLoaderState();
}

class _WardrobeColorShimmerLoaderState extends State<WardrobeColorShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
        right: 34,
        top: 70,
        bottom: 30,
      ),
      child: Column(
        children: List.generate(8, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            height: 70.0,
            child: ShimmerLoader(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
            ),
           ),
          );
        }),
      ),
    );
  }
}

class FolderShimmerLoader extends StatefulWidget {

  const FolderShimmerLoader({Key? key}) : super(key: key);

  @override
  State<FolderShimmerLoader> createState() => _FolderShimmerLoaderState();
}

class _FolderShimmerLoaderState extends State<FolderShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: List.generate(4, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            height: 35.0,
            child: ShimmerLoader(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.grey[300],
              ),
            ),
           ),
          );
        }),
      ),
    );
  }
}