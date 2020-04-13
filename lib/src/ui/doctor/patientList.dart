import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/detailsPage.dart';

class PatientList extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: StreamBuilder(
        initialData: null,
        stream: _firestore.collection('patientList').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    snapshot.data.documents[index].data["name"],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Details(
                          patient: snapshot.data.documents[index],
                        ),
                      ),
                    );
                  },
                  trailing: Icon(Icons.arrow_right),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
