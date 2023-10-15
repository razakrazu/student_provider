import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/core/color.dart';
import 'package:studentapp_provider/provider/database.dart';

class DailogProvider with ChangeNotifier {
  void success(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('update successful'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 10),
      action: SnackBarAction(
          label: 'undo', onPressed: () => Navigator.of(context).pop),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void notSuccess(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Image not added'),
      backgroundColor: const Color.fromARGB(255, 137, 2, 2),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(left: 10),
      action: SnackBarAction(
          label: 'undo', onPressed: () => Navigator.of(context).pop),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> dialogBuilder(BuildContext context, int index) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete', style:
                                    TextStyle(fontWeight: FontWeight.bold)),
            content: const Text('Do want to delete'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('cancel' , style:
                                    TextStyle(fontSize: 15, color: colorblack ))),
              TextButton(
                  onPressed: () {
                    final student =
                        Provider.of<StudentData>(context, listen: false);
                    student.deleteStudent(index);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete', style:
                                    TextStyle(fontSize: 15, color: colorblack ))),
            ],
          );
        });
  }
}
