
import 'dart:io';

import 'package:hw_contact_saver/models/contact_model.dart';
import 'package:path_provider/path_provider.dart';

class StorageService{

  static Future<String> _getDirectoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<Directory> getDirectory() async{
    Directory directory = Directory(await _getDirectoryPath());
    return directory;
  }

  static Future<File>createNewFile(String fileName) async{
    final String directoryPath = await _getDirectoryPath();
    File file = File("$directoryPath/$fileName.txt");
    return file;
  }

  static Future<File> writeToFile(String fileName, Contact contact) async{
    File file = await createNewFile(fileName);
    return file.writeAsString(contact.toString());
  }

  static Future<String> readFromFile(String fileName)async{
    try{
      File file = await createNewFile(fileName);
      return file.readAsString();
    }catch(e){
      return '0';
    }
  }
}