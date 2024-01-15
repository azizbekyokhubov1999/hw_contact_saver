import 'dart:io';

import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../services/storage_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const id = '/home_page';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  late Contact contact;
  final String fileName = 'contacts';
  List<File> fileList = [];
  List<Directory> directoryList = [];
  List<Contact> contacts = [];
  bool isLoading = false ;



  @override
  void initState(){
    StorageService.getDirectory().then((value) {
      value.listSync().forEach((element) {
        if(element.path.endsWith(".txt")){
          if(element is File){
            fileList.add(element);
          }
        }
      });
    });
    isLoading = true;
    super.initState();
    loadContacts();
  }
  Future<void> loadContacts() async {
    List<Contact> loadedContacts = await StorageService.readFromFile(fileName);
    setState(() {
      contacts = loadedContacts;
    });
  }

  Future<void> deleteContact(int index) async {
    await StorageService.deleteContact(fileName, index, contacts);
    loadContacts();
  }

  Widget saveBtn(){
    return Padding(
      padding: const EdgeInsets.only(left: 250),
      child: SizedBox(
        height: 40,
        width: 100,
        child: MaterialButton(
          onPressed: () async {
            String name = controllerName.text;
            String phoneNumber = controllerPhoneNumber.text;
            Contact newContact = Contact(phoneNumber: phoneNumber, name: name);
            contacts.add(newContact);
            await StorageService.writeToFile(fileName, contacts);
            loadContacts();
            // setState(() {});
            await StorageService.readFromFile(fileName);
            // isLoading = true;
            // fileList.add(file);
            setState(() {});
            controllerName.clear();
            controllerPhoneNumber.clear();
            Navigator.pop(context);
          },
          color: Colors.green,
          child: const Text('Save',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
            "Phone",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        backgroundColor: Colors.white70,
                        appBar: AppBar(
                          backgroundColor: Colors.green,
                          leading: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back,
                              color: Colors.black87,
                              size: 30,
                            ),
                          ),
                          flexibleSpace: Padding(
                            padding: const EdgeInsets.only(left: 55, top: 15),
                            child: Row(
                              children: [
                                const Text('SIM 2',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),),
                                IconButton(
                                    onPressed: (){},
                                    icon: const Icon(Icons.arrow_drop_down,
                                      size: 25,
                                      color: Colors.black87,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        resizeToAvoidBottomInset: false,
                        body:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 6,
                                          offset: Offset(0,2)
                                      )
                                    ]
                                ),
                                child:  TextField(
                                  controller: controllerName,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20
                                    ),
                                    prefixIcon: Icon(Icons.person,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, left: 10),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 6,
                                          offset: Offset(0,2)
                                      )
                                    ]
                                ),
                                child:  TextField(
                                  controller: controllerPhoneNumber,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20
                                    ),
                                    prefixIcon: Icon(Icons.phone,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                  ),

                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            saveBtn(),

                          ],
                        ),

                      );
                    }
                );

              },
              icon: const Icon(
                Icons.add,
                color: Colors.black87,
                size: 30,
              )
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.search_rounded,
              size: 30,
              color: Colors.black87,
            ),
          ),
          IconButton(
              onPressed: (){},
              icon:  const Icon(
                  Icons.more_vert,
                size: 30,
                color: Colors.black87,
              )
          ),
        ],
      ),
      body: isLoading?
      Column(
        children: [
          ListView.builder(
            itemCount: contacts.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.blue,
                    child: Text(
                      contacts[index].name.isNotEmpty
                          ? contacts[index].name[0].toUpperCase()
                          : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    contacts[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    contacts[index].phoneNumber,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    deleteContact(index);
                  },
                )
              );
            },
          ),
        ],
      )
          : const  Center(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                Text(
              'If you want to create new contact, press plus key',
               style: TextStyle(
                 fontSize: 15,
               ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:(){},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}