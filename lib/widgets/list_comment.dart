import 'package:flutter/material.dart';
import 'package:location_app/widgets/rate.dart';

class ListComment extends StatelessWidget {
  final size;
  final liste;
  ListComment({this.size, this.liste});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    liste[index].fullname == null
                        ? ""
                        : liste[index].fullname.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      liste[index].fullname == null
                          ? ""
                          : liste[index].fullname,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Rate(liste[index].rate == null ? 1 : liste[index].rate ~/ 2,
                        20),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                      liste[index].comment == null ? "" : liste[index].comment),
                ),
              ),
            ),
          );
        },
        itemCount: liste.length,
      ),
    );
  }
}
