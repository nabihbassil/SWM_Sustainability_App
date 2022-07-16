import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/single_action.dart';
import 'package:swm_app/services/user_service.dart';

class TakeAction extends StatefulWidget {
  int id;
  TakeAction({Key? key, required this.id}) : super(key: key);

  @override
  _TakeActionState createState() => _TakeActionState(id);
}

class _TakeActionState extends State<TakeAction> {
  int id;
  _TakeActionState(this.id);
  var ActDone;
  List L1 = ['0'];
  List L2 = ['0'];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    GetActionDone(id);
  }

  GetActionDone(id) async {
    await UserService().GetAllActionDone().then((value) => L1 = value);
    L2 = L1;
    if (mounted) {
      setState(() {
        L1;
        L2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GetActionDone(id);
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PageHolder()));
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                    height: 17,
                    width: 500,
                    child: Image.asset(
                      'assets/progressbardummy.png',
                      fit: BoxFit.contain,
                    )),
                const SizedBox(height: 25),
                const Padding(
                    padding: EdgeInsets.only(right: 250),
                    child: Text("Tasks",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 23, 69, 95),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 30),
                // need to make text.rich a const?
                Padding(
                  padding: const EdgeInsets.only(right: 220),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 200, 136, 11),
                          fontWeight: FontWeight.bold),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                              height: 34,
                              width: 34,
                              child: Image.asset(
                                'assets/tasktimer.png',
                                fit: BoxFit.contain,
                              )),
                        ),
                        const TextSpan(
                          text: ' To Do',
                        )
                      ],
                    ),
                  ),
                ),
                // spacing btw to do title and tasks
                const SizedBox(height: 10),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('takeactions')
                        .where("parentmoduleid", isEqualTo: id)
                        .where(FieldPath.documentId, whereNotIn: L1)
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading...'));
                      }
                      return Expanded(
                          child: ListView(
                        shrinkWrap: false,
                        children: snapshot.data!.docs.map((item) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 10),
                                      // Foreground color
                                      onPrimary: Colors.amber,
                                      // Background color
                                      primary: const Color.fromARGB(
                                          255, 255, 239, 199)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleActionScreen(
                                                  id: item.reference.id,
                                                  modID: id,
                                                )));
                                  },
                                  child: Text(
                                    item['actiontitle'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 228, 169, 18),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ));
                    }),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(right: 220),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 85, 148, 75),
                          fontWeight: FontWeight.bold),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                              height: 32,
                              width: 32,
                              child: Image.asset(
                                'assets/taskcheck.png',
                                fit: BoxFit.contain,
                              )),
                        ),
                        const TextSpan(
                          text: ' Done',
                        )
                      ],
                    ),
                  ),
                ),
                // space btw completed title and tasks
                const SizedBox(height: 10),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('takeactions')
                        .where("parentmoduleid", isEqualTo: id)
                        .where(FieldPath.documentId, whereIn: L2)
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                      if (!snapshot1.hasData) {
                        print("snaps");
                        return const Center(child: Text('Loading...'));
                      }
                      return Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        children: snapshot1.data!.docs.map((item1) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60, vertical: 10),
                                      // Foreground color
                                      onPrimary: Colors.lightGreen,
                                      // Background color
                                      primary: const Color.fromARGB(
                                          255, 215, 240, 206)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleActionScreen(
                                                  id: item1.reference.id,
                                                  modID: id,
                                                )));
                                  },
                                  child: Text(
                                    item1['actiontitle'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 85, 148, 75),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ));
                    }),
                const SizedBox(height: 8),
              ]),
        ),
      ),
    );
  }
}
