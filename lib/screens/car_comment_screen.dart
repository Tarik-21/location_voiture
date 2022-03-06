import 'package:flutter/material.dart';
import 'package:location_app/providers/feedbacks.dart';
import 'package:location_app/widgets/list_comment.dart';
import 'package:location_app/widgets/rate.dart';
import 'package:provider/provider.dart';

class CarComment extends StatefulWidget {
  static const routeName = '/car-comment';

  @override
  _CarCommentState createState() => _CarCommentState();
}

class _CarCommentState extends State<CarComment> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<FeedBacks>(context)
          .getAllCommentCar(ModalRoute.of(context).settings.arguments as String)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) => print("Error"));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final feedbackData = Provider.of<FeedBacks>(context);
    final feedBackscar = feedbackData.feedbackscar;

    return Scaffold(
        appBar: AppBar(
          title: Text("Comment"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              )
            : feedBackscar.length == 0
                ? Center(
                    child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: size.width * 0.4,
                          child: Image.asset("assets/images/comment.png"),
                        ),
                      ),
                      Text(
                        "No Comment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ))
                : ListComment(
                    size: size,
                    liste: feedBackscar,
                  ));
  }
}
