import 'package:flutter/material.dart';
import 'package:interview/login_page/login_page.dart';
import 'package:interview/login_page/model/user_model.dart';
import 'package:interview/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page/model/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DioClient _client = DioClient();
  @override
  void initState() {
    print("_________^^^^^^$_client");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightApp = MediaQuery.of(context).size.height;
    var widthApp = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: FutureBuilder<User?>(
          future: _client.getUser(id: '1'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                Data userData = userInfo.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData.avatar),
                      maxRadius: 80,
                      minRadius: 60,
                    ),
                    SizedBox(height: heightApp * 0.01),
                    Text(
                      '${userInfo.data.firstName} ${userInfo.data.lastName}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      userData.email,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: heightApp * 0.03),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.amber,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const MyApp();
                        }));
                      },
                      child: Text(
                        "logout".toLowerCase(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
