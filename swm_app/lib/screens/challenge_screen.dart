import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeScreen extends StatefulWidget {
  int id;
  ChallengeScreen({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChallengeScreenState createState() => _ChallengeScreenState(id);
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int id;
  _ChallengeScreenState(this.id);
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
                        Text(
                          item['actiontitle'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(item['actioncontent'].replaceAll("\\n", "\n")),
                        SizedBox(
                          height: 200,
                          child: Image.network(item['actionimg']),
                        ),
                        Text(
                          item["actionpts"] + "pts",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.greenAccent,
                              fontStyle: FontStyle.italic),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !item['done']
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // Foreground color
                                        onPrimary: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        // Background color
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      onPressed: () {
                                        _isButtonDisabled
                                            ? null
                                            : FirebaseFirestore.instance
                                                .collection('takeactions')
                                                .doc(item.reference.id)
                                                .update({'done': true});
                                      },
                                      child: Text(_isButtonDisabled
                                          ? "Completed"
                                          : "Complete Action"),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // Foreground color
                                        onPrimary: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        // Background color
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      onPressed: null,
                                      child: const Text('Completed'),
                                    )
                            ])
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
