import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hw_contact_saver/models/contact_model.dart';
import 'package:hw_contact_saver/services/storage_service.dart';
class DetailPage extends StatefulWidget {

  const DetailPage({super.key});

  static const id = '/detail_page';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  late Contact contact;


  void loadContact() {
    contact.name = controllerName.text;
    contact.phoneNumber = controllerPhoneNumber.text;
  }

  Widget saveBtn(){
    return Padding(
      padding: const EdgeInsets.only(left: 250),
      child: SizedBox(
        height: 40,
        width: 100,
        child: MaterialButton(
          onPressed: () {},
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
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.arrow_back,
          color: Colors.black87,
          size: 30,
          ),
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 55, top: 28),
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
}
