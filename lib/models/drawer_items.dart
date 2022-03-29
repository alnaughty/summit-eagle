import 'package:flutter/material.dart';

class CustomDrawerItems {
  final String title;
  final Widget child;
  final IconData icon;
  final ValueChanged<int> onTap;
  const CustomDrawerItems({
    required this.child,
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
