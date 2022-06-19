import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleActionScreen extends StatefulWidget {
  int id;
  SingleActionScreen({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SingleActionScreenState createState() => _SingleActionScreenState(id);
}

class _SingleActionScreenState extends State<SingleActionScreen> {
  int id;
  _SingleActionScreenState(this.id);
  late bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _isButtonDisabled = false;
  }

  void _DisableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Query _collectionRef = FirebaseFirestore.instance
        .collection('takeactions')
        .where("actionID", isEqualTo: id);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/SWM.png",
          height: 100,
          width: 100,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: _collectionRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return ListView(
                children: snapshot.data!.docs.map((item) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Container(
                            width: 300,
                            child: Text(
                              item['actiontitle'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 18, 68, 10),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Container(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['actionimg'],
                            height: 170.0,
                          ),
                        ),
                        Container(height: 20),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              width: 290,
                              child: Text(
                                item['actioncontent'].replaceAll("\\n", "\n"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !item['done']
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // Foreground color
                                        onPrimary:
                                            Color.fromARGB(255, 228, 170, 18),
                                        // Background color
                                        primary:
                                            Color.fromARGB(255, 255, 239, 199),
                                        minimumSize: Size(200, 50),
                                      ),
                                      onPressed: () {
                                        _isButtonDisabled
                                            ? null
                                            : FirebaseFirestore.instance
                                                .collection('takeactions')
                                                .doc(item.reference.id)
                                                .update({'done': true});
                                      },
                                      child: Text(
                                        _isButtonDisabled
                                            ? "Good Job on Completing the Task"
                                            : "I Did This!",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // Foreground color
                                        onPrimary:
                                            Color.fromARGB(255, 85, 148, 75),
                                        // Background color
                                        primary:
                                            Color.fromARGB(255, 255, 255, 255),
                                        minimumSize: Size(200, 50),
                                      ),
                                      onPressed: null,
                                      child: const Text(
                                          'Good Job on Completing the Task!',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 85, 148, 75),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold)),
                                    )
                            ]),
                        Container(height: 10),
                        Text(
                          item["actionpts"] + "pts",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 228, 170, 18),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
