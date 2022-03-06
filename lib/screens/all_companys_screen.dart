import 'package:flutter/material.dart';
import 'package:location_app/providers/companys.dart';
import 'package:location_app/screens/company_details_screen.dart';
import 'package:provider/provider.dart';

class AllCompanysScreen extends StatelessWidget {
  static const routeName = '/all-companys';

  @override
  Widget build(BuildContext context) {
    final companysData = Provider.of<Companys>(context);
    final companys = companysData.companys;

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("All Companys"),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                elevation: 4,
                child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          CompanyDetailsScreen.routeName,
                          arguments: companys[index]);
                    },
                    leading: Container(
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          companys[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(companys[index].name),
                    subtitle: Text(companys[index].offers_id.length.toString()),
                    trailing: Container(
                      width: size.width * 0.25,
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Text(companys[index].rate.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              )),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Excellent",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
          itemCount: companys.length,
        ));
  }
}
