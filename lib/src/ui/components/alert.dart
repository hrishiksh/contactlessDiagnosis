import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thanks'),
      elevation: 5,
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/report.svg',
                height: 150,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'See You tomorrow !',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            // share(context);
          },
          child: Text('Share Now'),
          //TODO: if possible use share now
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        )
      ],
    );
  }

  // void share(context) {
  //   final RenderBox box = context.findRenderObject();
  //   Share.share(
  //       //TODO: Change the url with app url
  //       'Yey, my CoronaVirus test result is normal. Check yours www.google.com',
  //       subject: 'Covid-19 test Result',
  //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  // }
}
