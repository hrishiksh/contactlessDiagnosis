import 'package:flutter/material.dart';
import './body.dart';
import 'patientList.dart';
import 'addSchedule.dart';

class DoctorMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          textTheme: Theme.of(context).appBarTheme.textTheme,
          title: Text(
            'Helping Hand',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // showSearch(
                  //   context: context,
                  //   delegate: PatientSearch(),
                  // );
                })
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            tabs: [
              Tab(
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Tab(
                child: Text(
                  'Patient',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DoctorBody(),
            PatientList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSchedule(),
              ),
            );
          },
          child: Icon(Icons.create),
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

// class PatientSearch extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(icon: Icon(Icons.clear), onPressed: null),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//        ),
//       onPressed: null,
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {

//     query // This is coming from the search
//     patientlist.where()//this is the search way;
//     // return ListView.builder(
//     //   itemCount: 1,
//     //   itemBuilder: (BuildContext context, int index) {
//     //   return ;
//     //  },
//     // );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
