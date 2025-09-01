import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  const CustomListtile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(subtitle),
        trailing: Text(trailing, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
