import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:interview/login_page/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> mydatalist = [];
  Map<String, dynamic> mydata = {};
  @override
  void initState() {
    getData();

    print("_________^^^^^^$mydatalist");
    super.initState();
  }

  getData() async {
    String url = "https://myjson.dit.upm.es/api/bins/gbt5";

    try {
      Dio dio = Dio();
      Response response = await dio.get(url);

      Data ur1 = Data(
          emailId: response.data['email'],
          name: response.data['name'],
          profilePic: response.data['profilePic']);

      if (response.statusCode == 200) {
        // ValueNotifier(mydata).value = mydata;
        print(ur1.emailId);
        mydatalist.add(ur1);
      }
    } on DioError catch (e) {
      print(e);
    }
    return mydata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 350,
        color: Colors.red,
        child: ListView.builder(
          itemCount: mydatalist.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    await getData();
                    setState(() {});
                  },
                  color: Colors.red,
                  child: const Text("click"),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(mydatalist[index].profilePic!),
                  maxRadius: 150.0,
                  minRadius: 120,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("User Email Id -"),
                    Text(mydatalist[index].emailId!)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("User Name -"),
                    Text(mydatalist[index].name!)
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
