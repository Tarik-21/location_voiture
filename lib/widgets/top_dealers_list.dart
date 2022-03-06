import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:location_app/providers/company.dart';
import 'package:location_app/screens/company_details_screen.dart';

class TopDealersList extends StatelessWidget {
  const TopDealersList({
    Key key,
    @required this.size,
    @required this.companys,
  }) : super(key: key);

  final Size size;
  final List<Company> companys;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.22,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.of(context).pushNamed(CompanyDetailsScreen.routeName,
                    arguments: companys[index]);
              },
              child: Container(
                width: size.width * 0.35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 20,
                        spreadRadius: 10,
                        offset: Offset(2, 2),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: LayoutBuilder(builder: (ctx, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: constraints.maxWidth * 0.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                companys[index].imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      flex: 1,
                      child: LayoutBuilder(builder: (ctx, constraints) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: constraints.maxWidth * 0.8,
                            child: RatingBar.builder(
                              initialRating: companys[index].rate / 2,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (ctx, _) => Icon(
                                Icons.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      flex: 2,
                      child: LayoutBuilder(builder: (ctx, constraints) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: constraints.maxWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  companys[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(companys[index]
                                    .offers_id
                                    .length
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: companys.length,
      ),
    );
  }
}
