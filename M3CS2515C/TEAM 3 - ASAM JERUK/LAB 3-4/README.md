# Lab Work 3

## Database

1. Group of 4
2. Using Android Studio or VS Code to connect database backend.
3. Using Firebase or Sqlite as a Database.
4. Using a Streamlab or OBS Studio to create Speed Code Video.
5. Recreate Login form.
6. Run. 

**************************************************************************

# Lab Work 4

## CRUD

1. Group of 4
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music + End with Highlight on VSCode final coding pages
5. Create form for User Information.
6. Create form other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD

--------------------------------------------------------------------------

### LINK FOR LAB 3&4 : 

Link speedcode : https://youtu.be/WHtTb-5GnYY?si=oC32ZM5OlvsVmn7B

Link source code: https://github.com/thisisnotmasyi/ICT602-LAB4.git

***************************************************************************

## create form for user information

```
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD Operations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  newName = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Name'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  documentID = value;
                });
              },
              decoration: InputDecoration(labelText: 'Document ID (Leave empty to generate)'),
            ),
            ElevatedButton(
              onPressed: () {
                createStudent();
              },
```


//display information

```
final students = snapshot.data!.docs;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final data = student.data() as Map<String, dynamic>;
                final name = data['name'] as String;
                final documentID = student.id;
                return ListTile(
                  title: Text('Name: $name'),
                  subtitle: Text('Document ID: $documentID'),
                );
              },
```



