import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/single_action.dart';
import 'package:swm_app/services/user_service.dart';

/*
On this screen, users can see what actions they can do to be more sustainable
 */

class TakeAction extends StatefulWidget {
  int id;
  TakeAction({Key? key, required this.id}) : super(key: key);

  @override
  _TakeActionState createState() => _TakeActionState(id);
}

class _TakeActionState extends State<TakeAction> {
  int id; //module id
  _TakeActionState(this.id);
  List listActionsToDo = ['0']; //list of IDs of actions not done
  List listActionsDone = ['0']; //list of IDs of actions  done

  @override
  void dispose() {
    super.dispose();
  }

/* 
  This function returns a List of all completed actions IDs from the user

  Inputs:
  *id: module id

  Outputs:
  * List of of action IDs completed and not completed saved in the state
  
*/
  GetActionDone(id) async {
    //call the user services to retrieve data
    await UserService()
        .GetAllActionDone()
        .then((value) => listActionsToDo = value);
    listActionsDone = listActionsToDo;
    if (mounted) {
      setState(() {
        listActionsToDo;
        listActionsDone;
      });
    }
  }

//on init we get all actions done to make the two lists
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    GetActionDone(id);
  }

  @override
  Widget build(BuildContext context) {
    GetActionDone(id); //not necessary anymore
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
        ), //navigate to previous screen
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PageHolder()));
            }, //navigate to home screen
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 255, 249, 237),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ExpansionTile(
                          title: Container(
                              height: 80,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                      height: 34,
                                      width: 34,
                                      child: Image.asset(
                                        'assets/tasktimer.png',
                                        fit: BoxFit.contain,
                                      )),
                                  const Text(
                                    'Actions To Do',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 80, 80, 80),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          children: [
                            // I'll name the data fr
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 280,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 240,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: (FutureBuilder(
                                      //load all actions that are not in the list of IDs of actions done
                                      future: FirebaseFirestore.instance
                                          .collection('takeactions')
                                          .where("parentmoduleid",
                                              isEqualTo: id)
                                          .where(FieldPath.documentId,
                                              whereNotIn: listActionsToDo)
                                          .get(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                              child: Text('Loading...'));
                                        }
                                        // If there is no data then return the line "Good job on completing all the actions for this challenge!
                                        return Column(children: [
                                          Expanded(
                                              child: ListView(
                                            shrinkWrap: false,
                                            children:
                                                snapshot.data!.docs.map((item) {
                                              return SingleChildScrollView(
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Column(children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      minimumSize: Size(
                                                                          MediaQuery.of(context).size.width -
                                                                              40,
                                                                          40),
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              10,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      // Foreground color
                                                                      onPrimary:
                                                                          Colors
                                                                              .amber,
                                                                      // Background color
                                                                      primary: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          255,
                                                                          239,
                                                                          199)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => SingleActionScreen(
                                                                              id: item.reference.id,
                                                                              modID: id,
                                                                            )));
                                                              }, //navigate to see more info about the action
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              Image.asset(
                                                                            item['actionicon'],
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          )),
                                                                      Expanded(
                                                                        child:
                                                                            ListTile(
                                                                          title: Text(
                                                                              item['actiontitle'],
                                                                              style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 228, 169, 18), fontWeight: FontWeight.bold)),
                                                                          subtitle: Html(
                                                                              data: item['actioncontent'].substring(0, 60) + '...',
                                                                              style: {
                                                                                "p": Style(color: Color.fromARGB(255, 0, 0, 0), fontStyle: FontStyle.italic)
                                                                              }),
                                                                          isThreeLine:
                                                                              false,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        '+' +
                                                                            item['actionpts'] +
                                                                            ' pts',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                228,
                                                                                169,
                                                                                18)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                      ])));
                                            }).toList(),
                                          )),
                                        ]);
                                      })),
                                )),
                          ],
                          initiallyExpanded: true,
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 243, 255, 241),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ExpansionTile(
                            title: Container(
                                height: 80,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                        height: 32,
                                        width: 32,
                                        child: Image.asset(
                                          'assets/taskcheck.png',
                                          fit: BoxFit.contain,
                                        )),
                                    const Text(
                                      'Actions Completed',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 80, 80, 80),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            children: [
                              // I'll name the data fr
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 350,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: (FutureBuilder(
                                        //load all actions that are in the list of IDs of actions done
                                        future: FirebaseFirestore.instance
                                            .collection('takeactions')
                                            .where("parentmoduleid",
                                                isEqualTo: id)
                                            .where(FieldPath.documentId,
                                                whereIn: listActionsDone)
                                            .get(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot1) {
                                          if (!snapshot1.hasData) {
                                            return const Center(
                                                child: Text('Loading...'));
                                          }
                                          return ListView(
                                            shrinkWrap: true,
                                            children: snapshot1.data!.docs
                                                .map((item1) {
                                              return SingleChildScrollView(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              minimumSize: Size(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      40,
                                                                  60),

                                                              // Foreground color
                                                              onPrimary: Colors
                                                                  .lightGreen,
                                                              // Background color
                                                              primary: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  215,
                                                                  240,
                                                                  206)),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SingleActionScreen(
                                                                          id: item1
                                                                              .reference
                                                                              .id,
                                                                          modID:
                                                                              id,
                                                                        )));
                                                      }, //navigate to see more info about the action
                                                      child: Text(
                                                        item1['actiontitle'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 85, 148, 75),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ));
                                            }).toList(),
                                          );
                                        })),
                                  ))
                            ]))),
              ]),
        ),
      ),
    );
  }
}
