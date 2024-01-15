
import 'dart:convert';
import 'dart:io';

import 'package:hw_contact_saver/models/contact_model.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> _getDirectoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<Directory> getDirectory() async {
    Directory directory = Directory(await _getDirectoryPath());
    return directory;
  }

  static Future<File> createNewFile(String fileName) async {
    final String directoryPath = await _getDirectoryPath();
    File file = File("$directoryPath/$fileName.txt");
    return file;
  }

  static Future<File> writeToFile(String fileName, List<Contact> contacts) async {
    File file = await createNewFile(fileName);
    return file.writeAsString(jsonEncode(contacts.map((contact) => contact.toJson()).toList()));
  }

  static Future<List<Contact>> readFromFile(String fileName) async {
    try {
      File file = await createNewFile(fileName);
      if (await file.exists()) {
        String contents = await file.readAsString();
        List<dynamic> contactList = jsonDecode(contents);
        return contactList.map((contactMap) => Contact.fromJson(contactMap)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> deleteContact(String fileName, int index, List<Contact> contacts) async {
    contacts.removeAt(index);
    await writeToFile(fileName, contacts);
  }
}