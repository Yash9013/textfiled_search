// ignore_for_file: avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  TextEditingController searchitem = TextEditingController();

  List<Map<String, dynamic>> nation = [
    {
      'id': 1,
      'name': 'India',
    },
    {'id': 2, 'name': 'America'},
    {'id': 3, 'name': 'England'},
    {'id': 4, 'name': 'Canada'},
    {'id': 5, 'name': 'U.A.E'},
    {'id': 6, 'name': 'Germany'},
    {'id': 7, 'name': 'Russia'},
    {
      'id': 8,
      'name': 'Thailand',
    }
  ];

  List<Map<String, dynamic>> searchlist = [];

  @override
  void initState() {
    searchlist = nation;
    searchitem.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  List<Map<String, dynamic>> results = [];

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = nation;
    } else {
      results = nation
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      searchlist = results;
    });
  }

  @override
  void dispose() {
    searchitem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search with TextField',
          style:
              TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchitem,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.35),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.35),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () {
                   setState(() {
                      searchitem.clear();
                    results = searchlist;
                   });
                  },
                  icon: Icon(
                    Icons.close,
                    size: height * 0.025,
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  runFilter(value);
                  print('onchanged value $value');
                });
              },
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Expanded(
              child: searchlist.isEmpty
                  ? const Text('No search found')
                  : ListView.builder(
                      itemCount: searchlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.015),
                            child: ListTile(
                                leading: Container(
                                  height: height * 0.06,
                                  width: width * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.025),
                                      color: Colors.grey[500]),
                                  child: Center(
                                    child: Text(
                                      searchlist[index]['id'].toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.02),
                                    ),
                                  ),
                                ),
                                title:
                                    Text(searchlist[index]['name'].toString())),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
