import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
      body: const  Center(
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