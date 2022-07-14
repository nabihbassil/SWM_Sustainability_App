import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  final Query _collectionRef = FirebaseFirestore.instance
      .collection('badges')
      .where("module", isEqualTo: "general");

  final Query _collectionRef1 = FirebaseFirestore.instance
      .collection('badges')
      .where("module", isEqualTo: "consumption");

  final Query _collectionRef2 = FirebaseFirestore.instance
      .collection('badges')
      .where("module", isEqualTo: "energy");
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Badge Collection",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 70, 70, 70)),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Text(
                          "General",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 139, 161, 170)),
                        ))),
                    const SizedBox(height: 15),
                    // grid view

                    StreamBuilder(
                        stream: _collectionRef.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading...'));
                          }
                          return GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                            crossAxisCount: 4,
                            children: snapshot.data!.docs.map((item) {
                              return Container(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                if (item['earned'] == true) {
                                  return GestureDetector(
                                      onTap: () {
                                        badgespecifics(context, item['icon'],
                                            item['name'], item['description']);
                                      },
                                      child: Image(
                                          image: AssetImage(
                                              "assets/badges/badge" +
                                                  item['icon'] +
                                                  ".png")));
                                } else {
                                  return const Image(
                                      image: AssetImage(
                                          "assets/badges/nobadge.png"));
                                }
                              }));
                            }).toList(),
                          );
                        }),

                    // new
                    const SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Text(
                          "Consumption",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 139, 161, 170)),
                        ))),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: _collectionRef1.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading...'));
                          }
                          return GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                            crossAxisCount: 4,
                            children: snapshot.data!.docs.map((item) {
                              return Container(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                if (item['earned'] == true) {
                                  return GestureDetector(
                                      onTap: () {
                                        badgespecifics(context, item['icon'],
                                            item['name'], item['description']);
                                      },
                                      child: Image(
                                          image: AssetImage(
                                              "assets/badges/badge" +
                                                  item['icon'] +
                                                  ".png")));
                                } else {
                                  return const Image(
                                      image: AssetImage(
                                          "assets/badges/nobadge.png"));
                                }
                              }));
                            }).toList(),
                          );
                        }),
                    const SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Text(
                          "Energy",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 139, 161, 170)),
                        ))),
                    const SizedBox(height: 15),
                    StreamBuilder(
                        stream: _collectionRef2.snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading...'));
                          }
                          return GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                            crossAxisCount: 4,
                            children: snapshot.data!.docs.map((item) {
                              return Container(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                if (item['earned'] == true) {
                                  return GestureDetector(
                                      onTap: () {
                                        badgespecifics(context, item['icon'],
                                            item['name'], item['description']);
                                      },
                                      child: Image(
                                          image: AssetImage(
                                              "assets/badges/badge" +
                                                  item['icon'] +
                                                  ".png")));
                                } else {
                                  return const Image(
                                      image: AssetImage(
                                          "assets/badges/nobadge.png"));
                                }
                              }));
                            }).toList(),
                          );
                        }),
                  ])))
            ],
          ),
        ),
      ),
    );
  }
}

void badgespecifics(context, badgenum, badgename, badgedescription) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: ListView(children: <Widget>[
            const SizedBox(height: 20),
            SizedBox(
                height: 120,
                child: Image(
                    image:
                        AssetImage("assets/badges/badge" + badgenum + ".png"))),
            const SizedBox(height: 15),
            Text(
              badgename,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 130, 137)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Text(
                "   " +
                    badgedescription +
                    "\n\nCongratulations on earning the badge!",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 70, 70, 70)),
              ),
            )
          ])));
}
