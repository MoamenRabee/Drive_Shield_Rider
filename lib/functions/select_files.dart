import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rider/functions/my_navigation.dart';

Future<File?> selectImage(BuildContext context) async {
  try {
    File? file;
    final ImagePicker picker = ImagePicker();

    // ignore: use_build_context_synchronously
    await showModalBottomSheet(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      context: context,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  file = File(photo.path);
                }

                // ignore: use_build_context_synchronously
                MyNavigator.back(context);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera),
                    Text(
                      'التقط صورة',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  file = File(image.path);
                }

                // ignore: use_build_context_synchronously
                MyNavigator.back(context);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image),
                    Text(
                      'أخذ صورة',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
    return file;
  } catch (e) {
    log('$e');
    return null;
  }
}

Future<File?> selectPDF() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
      allowMultiple: false,
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      log('File Not Selected');
      return null;
    }
  } catch (e) {
    log('$e');
    return null;
  }
}
