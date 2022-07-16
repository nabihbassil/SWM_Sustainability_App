import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/services/user_service.dart';

class SingleActionScreen extends StatefulWidget {
  String id;
  int modID;
  SingleActionScreen({Key? key, required this.id, required this.modID})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SingleActionScreenState createState() => _SingleActionScreenState(id, modID);
}

class _SingleActionScreenState extends State<SingleActionScreen> {
  String id;
  int modID;
  _SingleActionScreenState(this.id, this.modID);
  late bool _isButtonDisabled;
  var _isActionDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _isButtonDisabled = false;
    CheckActionDone(id);
  }

  void _DisableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  UpdateUserPoints(points) {
    UserService().UpdatePoints(points);
  }

  UpdateActionDone(ID, modID) async {
    List LTasks = ['0'];
    bool isQuizDone = false;
    int notDoneLength = -1;

    UserService().UpdateActionDone(ID);
    LTasks =
        await UserService().GetAllActionDone().then((value) => LTasks = value);
    isQuizDone = await UserService().GetIfQuizDone(modID);
    notDoneLength = await UserService().GetSizeofToDoTasks(modID, LTasks);
    UserService().updateModuleLogic(modID, isQuizDone, notDoneLength);
  }

  CheckActionDone(ID) async {
    await UserService()
        .CheckActionDone(ID)
        .then((value) => _isActionDone = value);

    if (mounted) {
      setState(() {
        _isActionDone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CheckActionDone(id);
    final Query _collectionRef = FirebaseFirestore.instance
        .collection('takeactions')
        .where(FieldPath.documentId, isEqualTo: id);

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
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: double.infinity,
                              child: Text(
                                item['actiontitle'],
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )),
                          Container(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://images.pexels.com/photos/4997810/pexels-photo-4997810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                              width: double.infinity,
                            ),
                          ),
                          Container(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              item['actioncontent'].replaceAll("\\n", "\n"),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !_isActionDone
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // Foreground color
                                          onPrimary: const Color.fromARGB(
                                              255, 228, 170, 18),
                                          // Background color
                                          primary: const Color.fromARGB(
                                              255, 255, 239, 199),
                                          minimumSize: const Size(200, 50),
                                        ),
                                        onPressed: () {
                                          if (_isButtonDisabled) {
                                            null;
                                          } else {
                                            UpdateActionDone(
                                                item.reference.id, modID);
                                            UpdateUserPoints(
                                                int.parse(item['actionpts']));
                                          }
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
                                          onPrimary: const Color.fromARGB(
                                              255, 85, 148, 75),
                                          // Background color
                                          primary: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          minimumSize: const Size(200, 50),
                                        ),
                                        onPressed: null,
                                        child: const Text(
                                            'Good Job on Completing the Task!',
                                            style: TextStyle(
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
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
