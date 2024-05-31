import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?)
      onImageSelected; // Change ImageProvider<Object>? to File?
  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidget();
}

class _ImagePickerWidget extends State<ImagePickerWidget> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show a dialog to choose the image source
        final source = await showDialog<ImageSource>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.green.shade50.withOpacity(0.80),
              title: Text(
                'Choose image source',
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            );
          },
        );

        if (source != null) {
          final imagePicker = ImagePicker();
          final pickedImage = await imagePicker.pickImage(source: source);

          if (pickedImage != null) {
            setState(() {
              _imageFile = File(pickedImage.path);
              widget.onImageSelected(_imageFile); // Pass _imageFile directly
            });
          }
        }
      },
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: _imageFile != null
            ? Image.file(_imageFile!, fit: BoxFit.cover)
            : Icon(Icons.camera_alt_rounded, size: 60, color: Colors.grey[400]),
      ),
    );
  }
}
