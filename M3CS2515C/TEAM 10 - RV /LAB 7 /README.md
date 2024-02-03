# LAB WORK 7
## CRUD
1. Group of 4
2. Using VS Code use existing page insert button delete.
3. Using Firebase as a Database.
4. Try not to delete the data from database. It is just status show has being deleted.
5. The real delete action from database must be perform by an administrator only.
6. Run on Smartphone
7. Speed Code Video + Music.
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.
### LINK FOR YOUTUBE
https://youtu.be/ZAFHSQN7ieM
## CODE SNIPPET
### DELETE
```dart
// Function to handle the delete action
  Future<void> _onDelete(BuildContext context) async {
    await _onDeleteLogic(context, isAdmin);
  }

  // Function to handle app-only delete logic for normal users
  Future<void> _onAppDelete(BuildContext context) async {
    await _onDeleteLogic(context, false);
  }

  Future<void> _onDeleteLogic(BuildContext context, bool isAdmin) async {
    try {
      if (isAdmin) {
        // For administrators: Delete data from both app and Firebase
        await FirestoreService().deleteBook(title);
        print('Deleting data from both app and Firebase...');
        print('Delete completed.');
        Navigator.pop(context);
      } else {
        print('Simulating delete within the app...');

        Navigator.pop(context);

        await Future.delayed(Duration(milliseconds: 200));

        Navigator.pop(context);
      }
    } catch (error) {
      print('Error during deletion: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Book'),
                  content: Text('Are you sure you want to delete this book?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _onDelete(context);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title'),
            SizedBox(height: 10),
            Text('Author: $author'),
          ],
        ),
      ),
    );
  }
}
```
