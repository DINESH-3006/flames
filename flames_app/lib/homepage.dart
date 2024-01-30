import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String yourName = '';
  String partnerName = '';
  List<String> flames = ['f', 'l', 'a', 'm', 'e', 's'];

  Map<String, String> m = {
    "f": "You Are Friends!",
    "l": "Think You are in Love!",
    "a": "You got affection with him/her...",
    "m": "You two are getting married soon...",
    "e": "You are ENEMIES!",
    "s": "You are my Sister/Brother"
  };

  void findMyRelationship() {
    List<String> longestName = yourName.length > partnerName.length
        ? yourName.split('')
        : partnerName.split('');
    List<String> shortestName = yourName.length < partnerName.length
        ? yourName.split('')
        : partnerName.split('');
    final local = [...longestName];
    for (var it in local) {
      if (shortestName.contains(it)) {
        longestName.remove(it);
        shortestName.remove(it);
      }
    }
    int totLen = longestName.length + shortestName.length;
    final String res = getTheRelationship(totLen);
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('close')),
              ],
              title: const Text('Your Relationship...'),
              content: Text(m[res] ?? ""),
              contentPadding: const EdgeInsets.all(20.0),
            )));
  }

  String getTheRelationship(int totLen) {
    int ind = 0, val;
    List<String> tempFlames = List.from(flames);
    while (ind < 5) {
      if (totLen > tempFlames.length) {
        val = totLen;
        while (val > tempFlames.length) {
          val = val - (tempFlames.length);
        }
      } else {
        val = totLen;
      }
      // print('index: ${val-1} length: ${flames.length-ind}');
      tempFlames.remove(tempFlames[val - 1]);
      ind++;
    }
    return tempFlames[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          'Flames',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.lightBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  onChanged: ((value) {
                    yourName = value;
                  }),
                  // style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Your Name',
                    labelStyle: TextStyle(color: Colors.white),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: ((value) {
                  partnerName = value;
                }),
                // style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Your Partner Name',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
              onPressed: () {
                findMyRelationship();
              },
              child: const Text(
                'Find My Relationship',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            )
          ],
        ),
      ),
    );
  }
}
