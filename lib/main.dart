import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crud/src/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: FirebaseDemo(),
      ),
    );
  }
}

class FirebaseDemo extends StatelessWidget {
  final TextEditingController contactController = TextEditingController();
  final TextEditingController updatecontactController = TextEditingController();

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('contact');

  updateData(id, value) async {
    await collectionReference
        .doc(id)
        .update({'name': value}).then((value) => print('Updated'));
  }

  deleteData(id) async {
    await collectionReference
        .doc(id)
        .delete()
        .then((value) => print('Deleted'));
  }

  _onAlertButtonPressed1(context, id, value) {
    updatecontactController.text = value;
    AlertDialog alert = AlertDialog(
      title: Text('Edit Data'),
      content: TextField(
        onChanged: (value) {},
        controller: updatecontactController,
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          textColor: Colors.white,
          child: Text('CANCEL'),
          onPressed: () {
            Get.back();
          },
        ),
        FlatButton(
          color: Colors.green,
          textColor: Colors.white,
          child: Text('OK'),
          onPressed: () async {
            print(updatecontactController.text);
            await updateData(id, updatecontactController.text);
            Get.back();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Crud Application'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: contactController,
                      decoration: InputDecoration(hintText: 'Enter Data'),
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [
              Expanded(
                child: SizedBox(
                  child: RaisedButton(
                    child: Text('Add new Data'),
                    onPressed: () async {
                      if (contactController.text.trim().length == 0) {
                        Get.snackbar(
                            'Error Message', 'Textfield box is empty!');
                      } else {
                        await collectionReference
                            .add({'name': contactController.text}).then(
                                (value) => contactController.clear());
                      }
                    },
                  ),
                ),
              ),
            ]),
            Expanded(
              child: StreamBuilder(
                  stream: collectionReference.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data.docs
                            .map(
                              (DocumentSnapshot document) => Card(
                                child: ListTile(
                                  title: Text(document['name']),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      deleteData(document.id);
                                    },
                                  ),
                                  onTap: () async {
                                    _onAlertButtonPressed1(
                                        context, document.id, document['name']);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
