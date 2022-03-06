import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final int items;
  final double size;
  Rate(this.items, this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 5,
      height: size,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Icon(
            Icons.star,
            color: index < items ? Colors.amber : Colors.grey,
            size: size,
          );
        },
        itemCount: 5,
      ),
    );
  }
}
