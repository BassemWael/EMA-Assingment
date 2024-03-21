import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = "profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;
  final String _startingImagePath = 'assets/profile.png';
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Avoid excessive height on small screens
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.camera);
                setState(() {});
              },
              child: const Text('Camera'),
            ),
            const SizedBox(width: 20.0),
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
                setState(() {});
              },
              child: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            _imageFile != null
                ? InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: _buildDialogContent(context),
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.file(
                          _imageFile!,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        )),
                  )
                : InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: _buildDialogContent(context),
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          _startingImagePath,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        )),
                  )
          ],
        ),
      ),
    );
  }
}
