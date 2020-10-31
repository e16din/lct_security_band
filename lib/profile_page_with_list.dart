import 'package:flutter/material.dart';

class ProfilePageWithList extends StatelessWidget {
  //todo: set stateful to single selection and save selectedPosition
  ProfilePageWithList({Key key}) : super(key: key);

  var selectedPosition = 0;

  List<String> profiles = [
    'Строитель',
    'Прораб',
    'Крановщик',
    'Сварщик',
    'Менеджер',
    'Гость'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("Кто вы?", style: TextStyle(fontSize: 32)),
        ),
        body:
            //  SingleChildScrollView(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Кто вы?', style: TextStyle(fontSize: 22)),
            ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.blueGrey,
                      indent: 8,
                      endIndent: 8,
                      thickness: 0.5,
                      height: 0.5,
                    ),
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: profiles.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(0.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        title: Text(
                          profiles[index],
                          style: TextStyle(fontSize: 26),
                        ),
                        leading: CircleAvatar(backgroundColor: Color(0x33ff0000),),
                        onTap: () =>
                            onProfileSelected(context, index, profiles[index]),
                      ),
                    ))
        // ],
        // )),
        );
  }

  onProfileSelected(BuildContext context, int position, String profile) {
    selectedPosition = position;
    Navigator.pushNamed(context, '/TrackingPage');
  }
}
