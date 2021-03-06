import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:http/http.dart' as http;

import 'auth_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

File _image;

class _ProfileState extends State<ProfilePage> {
  var fioController;
  var locationController;
  var positionController;
  var companyController;
  var phoneController;

  final picker = ImagePicker();

  ProgressDialog progressDialog;

  Future pickImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxWidth: 200.0, maxHeight: 200.0);

    if (pickedFile != null) {
      cropImage(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  Future<Null> cropImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
    }
  }

  void clearImage() {
    _image = null;
  }

  @override
  void initState() {

    // - get: /api/worker/get-my-info, возвращает всю информацию о пользователе, пример данных для запроса:
    // {
    // "login": "user2",
    // "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6InVzZXIxIiwiaWF0IjoxNjA0MTc1NzgyfQ.YpTr-C0G7rGwvMsdX6-VRtqlq777jmGPGQAfv6AWpXo"
    // }, токен тот который был выдан при логине, возвращает вообще все поля пользователя, в дальнейшем я их отфильтрую

    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    progressDialog.style(
      message: 'Пожалуйста подождите..',
    );

    var json = jsonEncode(<String, dynamic>{
      'login': login,
      'token': token,
    });
    print('request: $json');

    http
        .post('http://ldt-transformation.nemezida.online/api/worker/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json)
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      Future.delayed(Duration(milliseconds: 600)).then((value) {
        progressDialog.hide();

        if (response.statusCode == 200) {
          var parsedJson = jsonDecode(response.body);
          // token = parsedJson['token'];
          print("token: $token");
        }
      });
    }).catchError((error) {
      print("Error: $error");
      hideProgressDialog();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 64)),
              Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(190),
                            child: _image == null
                                ? Icon(Icons.person)
                                : Image.file(_image),
                          ))))),
              Padding(
                  padding:
                      EdgeInsets.only(left: 32, right: 32, top: 24, bottom: 12),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: fioController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'ФИО',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24, color: Colors.blue),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 12),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: locationController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Локация',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 12),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: positionController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Должность',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 12),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: companyController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Компания',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24),
                      ))),
              Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
                  child: ColoredBox(
                      color: Color(0xa1ffffff),
                      child: TextFormField(
                        controller: phoneController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            labelText: 'Телефон',
                            hintStyle: TextStyle(fontSize: 24)),
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.phone,
                      )))
            ],
          ),
        ])));
  }

  void hideProgressDialog() {
    Future.delayed(Duration(milliseconds: 600)).then((value) {
      progressDialog.hide();
    });
  }
}
