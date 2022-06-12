import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final Query _collectionRef = FirebaseFirestore.instance.collection('modules');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Heading 1',
    <Entry>[
      Entry(
        'Sub Heading 1',
        <Entry>[
          Entry('Row 1'),
          Entry('Row 2'),
          Entry('Row 3'),
        ],
      ),
      Entry('Sub Heading 2'),
      Entry('Sub Heading 3'),
    ],
  ),
  Entry(
    'Heading 2',
    <Entry>[
      Entry('Sub Heading 1'),
      Entry('Sub Heading 2'),
    ],
  ),
  Entry(
    'Heading 3',
    <Entry>[
      Entry('Sub Heading 1'),
      Entry('Sub Heading 2'),
      Entry(
        'Sub Heading 3',
        <Entry>[
          Entry('Row 1'),
          Entry('Row 2'),
          Entry('Row 3'),
          Entry('Row 4'),
        ],
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
