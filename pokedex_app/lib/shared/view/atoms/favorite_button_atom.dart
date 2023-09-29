import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class FavoriteButtonAtom extends StatelessWidget {
  const FavoriteButtonAtom({
    super.key,
    this.filled = false,
    required this.onTap,
  });

  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onTap,
      color: Theme.of(context).colorScheme.secondary,
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      icon: Icon(filled ? Remix.heart_2_fill : Remix.heart_2_line),
    );
  }
}
