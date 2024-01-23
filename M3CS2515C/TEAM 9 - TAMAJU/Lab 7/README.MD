# Lab Work 7

## CRUD

1. Group of 3
2. Using VS Code use existing page insert button delete.
3. Using Firebase as a Database.
4. Try not to delete the data from database. It is just status show has being deleted.
5. The real delete action from database must be perform by an administrator only.
6. Run on Smartphone
7. Speed Code Video + Music.
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.

## LINK

https://youtu.be/2gHBT9I5Y5I

## CODE SNIPPET

### Delete Action

#### Catering Code

```
  Future<void> _deleteDataFromFirestore(String documentId) async {
    await _firestore.collection('caterings').doc(documentId).delete();
  }
```

#### Service Code

```
  Future<void> _deleteDataFromFirestore(String documentId) async {
    await _firestore.collection('addon').doc(documentId).delete();
  }
```

### Status Action

#### Catering Part

```
Future<void> _updateDataInFirestore(String documentId, String currentField1, bool? isAvailable) async {
    final TextEditingController _updateField1Controller = TextEditingController(text: currentField1);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _updateField1Controller,
                decoration: InputDecoration(labelText: 'Food Name'),
              ),
              Text('Is Available: ${isAvailable ?? false}'), // Display the current availability status
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedField1 = _updateField1Controller.text;
                await _firestore.collection('caterings').doc(documentId).update({
                  'field1': updatedField1,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () async {
                await _firestore.collection('caterings').doc(documentId).update({
                  'isAvailable': !(isAvailable ?? false), // Toggle the availability status in Firestore
                });
                Navigator.of(context).pop();
              },
              child: Text('Toggle Availability'),
            ),
          ],
        );
      },
    );
  }
```

#### Service Part

```
Future<void> _updateDataInFirestore(String documentId, String currentField1, bool? isAvailable) async {
    final TextEditingController _updateField1Controller = TextEditingController(text: currentField1);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _updateField1Controller,
                decoration: InputDecoration(labelText: 'Add-On Name'),
              ),
              Text('Is Available: ${isAvailable ?? false}'), // Display the current availability status
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedField1 = _updateField1Controller.text;
                await _firestore.collection('addon').doc(documentId).update({
                  'field1': updatedField1,
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () async {
                await _firestore.collection('addon').doc(documentId).update({
                  'isAvailable': !(isAvailable ?? false), // Toggle the availability status in Firestore
                });
                Navigator.of(context).pop();
              },
              child: Text('Toggle Availability'),
            ),
          ],
        );
      },
    );
  }
```
