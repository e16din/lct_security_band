import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfilePage> {
  var fioController;
  var locationController;
  var positionController;
  var companyController;
  var phoneController;




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
                        child: CircleAvatar(child: Icon(Icons.person)),
                      )),
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

}
