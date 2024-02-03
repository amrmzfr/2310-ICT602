# LAB WORK 6
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
https://youtu.be/cDDjfppKYEs
## CODE SNIPPET
### UPDATE
```dart
void _updateBook() {
    FirebaseFirestore.instance
        .collection('books')
        .doc(widget.documentId)
        .update({
      'title': _titleController.text,
      'author': _authorController.text,
      // Add more fields as needed
    }).then((_) {
      print('Book updated successfully');
      Navigator.pop(context); // Return to the previous screen after updating
    }).catchError((error) {
      print('Error updating book: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBook,
              child: Text('Update Book'),

```
