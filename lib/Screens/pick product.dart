import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yehia/constants/global%20method.dart';

class pick_product extends StatefulWidget {
  const pick_product({super.key});

  @override
  State<pick_product> createState() => _pick_productState();
}

class _pick_productState extends State<pick_product> {
  XFile? _pickedImage;
  bool isEditing = false;
  String? productNetworkImage;
  bool _isLoading = false;
  String? productImageUrl;
  void clearForm() {
    removePickedImage();
  }
  void removePickedImage() {
    setState(() {
      _pickedImage = null;
      productNetworkImage = null;
    });
  }
  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          productNetworkImage = null;
        });
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          productNetworkImage = null;
        });
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(child: Container(
                height: 100,
                color: Colors.grey[100],
                width: double.infinity,
                child: Image.asset('assets/images/RoشTaa logo 1.png',
                ))),
          ),
          const SizedBox(
            height: 20,
          ),
          if (productNetworkImage != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                productNetworkImage!,
                // width: size.width * 0.7,
                height: size.width * 0.5,
                alignment: Alignment.center,
              ),
            ),
          ] else if (_pickedImage == null) ...[
            SizedBox(
              width: size.width * 0.4 + 10,
              height: size.width * 0.4,
              child: DottedBorder(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          size: 80,
                          color: Colors.blue,
                        ),
                        TextButton(
                          onPressed: () {
                            localImagePicker();
                          },
                          child: Center(child: const Text("Pick  Image")),
                        ),
                      ],
                    ),
                  )),
            ),
          ] else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(
                  _pickedImage!.path,
                ),
                // width: size.width * 0.7,
                height: size.width * 0.5,
                alignment: Alignment.center,
              ),
            ),
          ],
          if (_pickedImage != null || productNetworkImage != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    localImagePicker();
                  },
                  child: const Text("Pick another image"),
                ),
                TextButton(
                  onPressed: () {
                    removePickedImage();
                  },
                  child: const Text(
                    "Remove image",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(
            height: 30.0,
          ),
          InkWell(
            onTap: (){},
            child: Center(
              child: Text('Processing',style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7441F2),
              ),),
            ),
          )


        ],
      ),
    );
  }
}
