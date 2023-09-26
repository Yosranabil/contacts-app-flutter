import 'package:flutter/material.dart';
import 'package:task6/Helper/db_helper.dart';
import 'package:task6/Model/User_model.dart';
import 'package:task6/Screens/profile_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  final _key = GlobalKey<FormState>();

  List<ContactModel> contacts = [];
  var db = DataBaseHelper();
  ContactModel ?contactModel;
  bool flag = false;
  String Fname = '', Number = '', Email = '';

  RegExp nameExp = RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$');
  RegExp phoneExp = RegExp(r'^(?:[0][1-9])[0-9]{9}$');
  RegExp emailExp = RegExp(r'\S+@\S+\.\S+');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            bottomStart: Radius.circular(20))),
        backgroundColor: const Color(0xFFAB72C0),
        title: const Text(
        'My Contacts',
      ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context)=>  ProfileScreen()),
                );
              },
              icon: const Icon(
                Icons.person,
              ),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            return createList(context, snapshot);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAlterDialog(null);
        },
          backgroundColor: const Color(0xFFAB72C0),
          child: const Icon(
          Icons.person_add_alt_1_rounded,
      ),
      ),
    );
  }

  Future<List<ContactModel>> _getData() async{

    await db.getAllContacts().then((value){
      contacts = value;
    });
    return contacts;
  }
  createList(BuildContext context, AsyncSnapshot snapshot) {
    contacts = snapshot.data ?? [];

    if(contacts != []){
      return ListView.builder(
        itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            onDismissed: (direction)
          {
            DataBaseHelper().deleteContact(contacts[index].id!);
          },
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsetsDirectional.only(end: 10),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.pink[200],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delete,
                ),
              ),
            ),
          direction: DismissDirection.endToStart,
            child: buildContactItem(contacts[index]),
        ),
        itemCount: contacts.length,
      );
    }else
      {
        return Container();
      }
  }
  Widget buildContactItem(ContactModel model) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[100],
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 15.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFFAB72C0),
                child: Text(
                  model.name.toString()[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    model.email.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    model.phone.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: (){
                  openAlterDialog(model);
                },
                icon: const Icon(Icons.edit,),
              ),
            ],
          ),
        ),
      ),
    );
  }
  openAlterDialog(ContactModel? contactModel) {
    if (contactModel != null) {
      Fname = contactModel.name!;
      Number = contactModel.phone!;
      Email = contactModel.email!;
      flag = true;
    } else {
      Fname = '';
      Number = '';
      Email = '';
      flag = false;
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Center(
          child: Text(
            'Contact Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: Fname,
                  onSaved: (value){
                    Fname = value!;
                  },
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter a name';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: Number,
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    Number = value;
                  },
                  validator: (value){
                    if(value!.isEmpty || !phoneExp.hasMatch(Number))
                    {
                      return 'A valid phone number should be 11 digits,\n begining with 0.';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: Email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    Email = value;
                  },
                  validator: (value){
                    if(value!.isEmpty || !emailExp.hasMatch(Email))
                    {
                      return 'A valid email should be not empty and \n in form of (@ .com).';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(_key.currentState!.validate()) {
                      flag ? editContact(contactModel!.id) : addContact();
                      setState(() {});
                    };
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(380, 50),
                    backgroundColor: const Color(0xFFAB72C0),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)) ,
                  ),
                  child: Text(
                    flag ? 'Edit Contact' : 'Add Contact',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void addContact() async {
    _key.currentState!.save();

    await db.insertContact(
        ContactModel(name: Fname, email: Email, phone: Number)).then((value){
      Navigator.of(context).pop();
      setState(() {
      });
    });
  }
  void editContact(int? id) {
    _key.currentState!.save();

    ContactModel contactModel = ContactModel(
      id: id,
      name: Fname,
      email: Email,
      phone: Number,
    );

    db.updateContact(contactModel)
        .then((value) {
      Navigator.pop(context);
      setState(() {
      });
    });
  }
}
