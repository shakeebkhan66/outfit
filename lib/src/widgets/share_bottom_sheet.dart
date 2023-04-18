import 'package:flutter/material.dart';
void showShareBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ListView(
        shrinkWrap: true,
        children: [
          _buildListTile(Icons.thumb_up, 'Like', Icons.favorite, 'Love', context),
          _buildListTile(Icons.comment, 'Comment', Icons.share, 'Share', context),
          _buildListTile(Icons.bookmark, 'Save', Icons.send, 'Send', context),
        ],
      );
    },
  );
}

ListTile _buildListTile(
    IconData leadingIcon, String leadingText, IconData trailingIcon, String trailingText, BuildContext context) {
  return ListTile(
    leading: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Handle Twitter button tap
          },
          icon: const Icon(
            Icons.twelve_mp,
            color: Colors.blue,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle Facebook button tap
          },
          icon: const Icon(
            Icons.facebook,
            color: Colors.blue,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle Pinterest button tap
          },
          icon: const Icon(
            Icons.pin,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle WhatsApp button tap
          },
          icon: const Icon(
            Icons.call,
            color: Colors.green,
          ),
        ),
      ],
    ),
    title: Text(leadingText),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Handle Favorite button tap
          },
          icon: Icon(
            trailingIcon,
            color: Colors.red,
          ),
        ),
        Text(trailingText),
      ],
    ),
  );
}
