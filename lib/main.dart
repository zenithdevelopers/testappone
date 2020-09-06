import 'package:flutter/material.dart';
import 'src/profile_detail_page.dart';
import 'dart:async';
import 'bloc/network_bloc.dart';
import 'package:testappone/models/user_info_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: "Test App"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    bloc.networkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final double gridHeight = (screenHeight - kToolbarHeight - 30) / 2;
    final double gridWidth = (screenWidth / 2);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
            stream: bloc.status,
            builder: (context, AsyncSnapshot<String> networkStatus) {
              if (networkStatus.hasData && networkStatus.data == "Online") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Your are " + networkStatus.data)));
                });
                return gridView(gridWidth, gridHeight, networkStatus.data);
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Your are " + networkStatus.data)));
                });
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget gridView(gridWidth, gridHeight, status) {
    return GridView.count(
      crossAxisCount: 2,
      physics: BouncingScrollPhysics(),
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      childAspectRatio: (gridWidth / gridHeight),
      padding: EdgeInsets.all(10),
      crossAxisSpacing: 4,
      mainAxisSpacing: 8,
      children:
          testData.map((data) => profileWidget(data, gridHeight)).toList(),
    );
  }

  Widget profileWidget(UserInfoModel data, height) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileDetailPage(dataList: testData, data: data)));
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(
              3.0,
              3.0,
            ),
          )
        ]),
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height / 1.45,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.imageUrl)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            data.universityName,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
