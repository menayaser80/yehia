import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yehia/cubit/cashe%20helper.dart';
class Photobook extends StatefulWidget {
  const Photobook({super.key});

  @override
  State<Photobook> createState() => _PhotobookState();
}

class _PhotobookState extends State<Photobook> {
  final List<XFile> _imageFiles = [];
  final List<XFile> like = [];
  List<String> images = [];
  List<int> indexForImages = [];

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFiles.add(pickedImage);
        images.add(pickedImage.path);
        CachHelper.saveImages(key: 'images', value: images);
      });
    }
  }

  @override
  void initState() {
    images = CachHelper.getImages(key: 'images')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Album'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () async {
                if(like.isNotEmpty){
                  await Share.shareXFiles(like,
                      subject: 'Look what I made!');
                }
              },
              child: Card(
                elevation: 10,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    IconlyLight.send,
                    size: 28,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (!indexForImages.contains(index)) {
                  indexForImages.add(index);
                  like.add(XFile(images[index]));
                }else{
                  indexForImages.remove(index);
                  like.remove(like[index]);
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.file(File(images[index])),
                indexForImages.contains(index)
                    ? Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                )
                    : SizedBox.shrink(),
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            images.remove(images[index]);
                            indexForImages.remove(index);
                            CachHelper.saveImages(key: 'images', value: images);
                          });
                        },
                        child: Icon(Icons.close,color: Colors.red,size: 28,))),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () => _pickImage(ImageSource.camera),
            tooltip: 'Take a Photo',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}