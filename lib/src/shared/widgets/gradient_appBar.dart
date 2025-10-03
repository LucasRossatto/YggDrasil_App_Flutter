import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<double>? stops;
  final Alignment begin;
  final Alignment end;
  final double elevation;
  final Widget? leading;

  const GradientAppBar({
    super.key,
    required this.title,
    this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.elevation = 4.0,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(title, style: TextStyle(color: theme.colorScheme.surface),),
      elevation: elevation,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 166, 62, 1),
              Color.fromRGBO(0, 122, 85, 1),
            ],
            stops: [0, 0.5],
            begin: begin,
            end: end,
          ),
        ),
      ),
      leading: leading,
    );
  }
}
