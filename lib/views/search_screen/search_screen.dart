import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lenswear_app/model/apparel.dart';
import 'package:lenswear_app/repository/apparel.dart';
import 'package:lenswear_app/views/search_screen/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

enum ImageState {
  free,
  picked,
  cropped,
}

class _SearchScreenState extends State<SearchScreen> {
  File? _image;
  late ImageState imageState;
  final picker = ImagePicker();
  final ApparelRepository _apparelRepository = ApparelRepository();

  @override
  void initState() {
    super.initState();
    imageState = ImageState.free;
  }

  _imgFromCamera() async {
    XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      imageState = ImageState.picked;
    }
  }

  _imgFromGallery() async {
    XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageState = ImageState.picked;
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _cropImage() async {
    File? croppedFile =
        await ImageCropper().cropImage(sourcePath: _image!.path);
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        imageState = ImageState.cropped;
      });
    }
  }

  void _search() async {
    if (_image != null) {
      List<Apparel> result =
          await _apparelRepository.getApparelsByImage(image: _image!);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchResultScreen(results: result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (imageState == ImageState.free)
              ? const Text('No image selected.')
              : Image.file(_image!),
          ActionButton(
            onPressFunc: () => _showPicker(context),
            buttonText: "pick image",
          ),
          if (imageState != ImageState.free)
            ActionButton(
              onPressFunc: () => _cropImage(),
              buttonText: "crop image",
            ),
          if (imageState != ImageState.free)
            ActionButton(
              onPressFunc: () => _search(),
              buttonText: "search!",
            )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final Function onPressFunc;
  final String buttonText;
  const ActionButton(
      {Key? key, required this.onPressFunc, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressFunc(),
        child: Text(buttonText),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
      ),
    );
  }
}
