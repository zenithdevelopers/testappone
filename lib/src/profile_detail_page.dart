import 'package:flutter/material.dart';
import 'package:testappone/models/user_info_model.dart';

class ProfileDetailPage extends StatefulWidget {
  ProfileDetailPage({Key key, this.dataList, this.data}) : super(key: key);
  List<UserInfoModel> dataList;
  UserInfoModel data;
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: controller,
          itemCount: widget.dataList.length,
          itemBuilder: (context, position) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                -5.0,
                                5.0,
                              ),
                            )
                          ],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.dataList[position].imageUrl)),
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dataList[position].name,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(widget.dataList[position].country,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black38)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                              "University: " +
                                  widget.dataList[position].universityName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ),
                        Text("Gender: " + widget.dataList[position].gender,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                    child: Text("About",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Text(widget.dataList[position].about,
                        style: TextStyle(fontSize: 18, color: Colors.black54)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
