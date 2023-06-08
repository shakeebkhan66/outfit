import 'package:flutter/material.dart';

import 'app_button_widget.dart';

class RefreshWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRefresh;
  const RefreshWidget({super.key, required this.error, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Text(error.toString()),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButtonWidget(
              onTap: onRefresh,
              title: "refresh",
            ),
          ),
        ],
      ),
    );
  }
}
