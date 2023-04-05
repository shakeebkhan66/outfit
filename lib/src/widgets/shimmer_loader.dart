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
            return GridTile(
              child: ShimmerLoader(
                child: Container(
                  color: Colors.grey[300],
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

