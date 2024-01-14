import 'dart:io';

import 'package:flutter/material.dart';

import '../services/storage_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const id = '/home_page';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isLoading = false;
  List<File> fileList = [];
  List<Directory> directoryList = [];


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
              onPressed: (){},
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
      body: isLoading ?
      Column(
        children: [
          ListView.builder(
            itemCount: fileList.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  title: Text(fileList[index].path),
                ),
              );
            },
          ),
        ],
      ) : const  Center(
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