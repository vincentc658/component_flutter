import 'dart:math';

import 'package:flutter/material.dart';
import 'package:research_component/PersonModel.dart';

class TestingListPageScreen extends StatefulWidget {
  const TestingListPageScreen({super.key});

  @override
  State<TestingListPageScreen> createState() => _TestingListPageScreenState();
}

class _TestingListPageScreenState extends State<TestingListPageScreen> {
  final TextEditingController controller = TextEditingController();
  bool isSelectionMode = false;

  List<PersonModel> _persons = [];
  List<PersonModel> _personsData = [];
  List<PersonModel> _selectedPersons = [];

  @override
  void initState() {
    super.initState();
    _persons = [
      PersonModel(
        id: "1",
        name: "Andi",
        status: 'Testing description',
        image: 'assets/person_1.jfif',
        isSelected: false,
      ),
      for (int i = 2; i < 12; i++)
        PersonModel(
          id: "$i",
          name: "Budi $i",
          status: 'Another description',
          image: new Random().nextInt(13)%2 == 0 ? 'assets/person_1.jfif' : 'assets/person_2.jfif',
          isSelected: false,
        ),
      PersonModel(
        id: "13",
        name: "Citra",
        status: 'Some description',
        image: 'assets/person_1.jfif',
        isSelected: false,
      ),
    ];
    _personsData.addAll(_persons);
    controller.addListener(() {
      _applyFilter();
    });
  }

  void _applyFilter() {
    final query = controller.text.toLowerCase();
    print('apply $query');
    setState(() {
      _persons =
          _personsData.where((person) {
            final matchesSearch = person.name.toLowerCase().contains(query);
            return matchesSearch;
          }).toList();
    });
  }

  void _toggleSelectionMode(int index) {
    setState(() {
      isSelectionMode = true;
      _toggleItemSelection(index);
    });
  }

  void _toggleItemSelection(int index) {
    setState(() {
      final person = _persons[index];
      if (person.isSelected) {
        _selectedPersons.remove(person);
      } else {
        _selectedPersons.add(person);
      }
      person.isSelected = !person.isSelected;
      // if (_selectedPersons.isEmpty) isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (isSelectionMode)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isSelectionMode = false;
                  for (var person in _persons) {
                    person.isSelected = false;
                  }
                  _selectedPersons.clear();
                });
              },
            ),
          if (!isSelectionMode)
            IconButton(
              icon: const Icon(Icons.grading),
              onPressed: () {
                setState(() {
                  isSelectionMode = true;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Contact',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: controller.text.isNotEmpty? Icon(Icons.close):null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if(isSelectionMode)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  for (int i = 0; i < _personsData.length; i++){
                    _toggleSelectionMode(i);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(_selectedPersons.length== _personsData.length?"Remove All":"Select All"),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _persons.length,
              itemBuilder: (context, index) {
                final person = _persons[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        person.isSelected
                            ? Colors.lightBlue.shade50
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          person.isSelected
                              ? Colors.blueAccent
                              : Colors.grey.shade300,
                      width: person.isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        person.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(person.name),
                    subtitle: Text(person.status),
                    trailing:
                        isSelectionMode
                            ? Checkbox(
                          checkColor: Colors.white,
                            activeColor: Colors.blueAccent,
                              value: person.isSelected,
                              onChanged: (_) => _toggleItemSelection(index),
                            )
                            : null,
                    onLongPress: () => _toggleSelectionMode(index),
                    onTap: () {
                      if (isSelectionMode) {
                        _toggleItemSelection(index);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (isSelectionMode && _selectedPersons.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              color: Colors.white,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Selected Contacts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedPersons.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final person = _selectedPersons[index];
                        return Column(
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    person.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        person.isSelected = false;
                                        _selectedPersons.remove(person);
                                        if (_selectedPersons.isEmpty) {
                                          isSelectionMode = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 60,
                              child: Text(
                                person.name,
                                style: const TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
