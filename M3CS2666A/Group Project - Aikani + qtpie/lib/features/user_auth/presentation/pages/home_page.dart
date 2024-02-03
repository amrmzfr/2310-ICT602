import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({Key? key}) : super(key: key);

  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
  FirebaseFirestore.instance.collection('items');

  String searchText = '';
  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked
            ? TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        )
            : const Text('CRUD Operation'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
              });
            },
            icon: Icon(isSearchClicked ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!streamSnapshot.hasData) {
            return Center(
              child: Text('No data available'),
            );
          }
          final List<DocumentSnapshot> items = streamSnapshot.data!.docs
              .where((doc) =>
              doc['name'].toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = items[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    documentSnapshot['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Phone No: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(documentSnapshot['number'].toString()),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Student No: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(documentSnapshot['sn'].toString()),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _update(documentSnapshot),
                        icon: Icon(Icons.edit),
                        color: Colors.green,
                      ),
                      IconButton(
                        onPressed: () => _delete(documentSnapshot.id),
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create your profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'eg.Amir',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _snController,
                decoration: const InputDecoration(
                  labelText: 'Student No',
                  hintText: 'eg.2022123123',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Phone No',
                  hintText: 'eg.60101231234',
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final int? sn = int.tryParse(_snController.text);
                    final int? number = int.tryParse(_numberController.text);
                    if (number != null) {
                      await _items.add({
                        "name": name,
                        "number": number,
                        "sn": sn,
                      });
                      _nameController.text = '';
                      _snController.text = '';
                      _numberController.text = '';
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text("Create"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    _nameController.text = documentSnapshot['name'];
    _snController.text = documentSnapshot['sn'].toString();
    _numberController.text = documentSnapshot['number'].toString();

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
      return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
            "Update your item",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'eg.Elon',
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _snController,
            decoration: const InputDecoration(
              labelText: 'Student No',
              hintText: 'eg.2022123123',
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _numberController,
            decoration: const InputDecoration(
              labelText: 'Phone No',
              hintText: 'eg.60101231234',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
          onPressed: () async {
        final String name = _nameController.text;
        final int? sn = int.tryParse(_snController.text);
        final int? number = int.tryParse(_numberController.text);
        if (number != null) {
          await _items
              .doc(documentSnapshot.id)
              .update({"name": name, "number": number, "sn": sn});
          _nameController.text = '';
          _snController.text = '';
          _numberController.text = '';
          Navigator.of(ctx).pop();
        }
          },
            child: const Text("Update"),
          ),
            ],
          ),
      );
        },
    );
  }

  Future<void> _delete(String itemId) async {
    await _items.doc(itemId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You have successfully deleted an item")),
    );
  }
}
