import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_detail.dart';
import 'package:intl/intl.dart';

import 'api/api_service.dart';


class Detail extends StatelessWidget {
  final String user;
  final ApiService api;

  const Detail({super.key, required this.user, required this.api});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: api.getDetail(user),
        builder: (BuildContext context, AsyncSnapshot<UserDetail?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            UserDetail? users = snapshot.data;
            return _buildDetailView(users);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailView(UserDetail? users) {
    DateTime userJoin = DateTime.parse(users!.createdAt.toString());
    String join = DateFormat('dd-MM-yyyy  kk:mm').format(userJoin);
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "GitHub User's Detail",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Bristle',
          ),
        ),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(

        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(users.avatarUrl.toString()),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    users.name.toString(),
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Harbor',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    users.location.toString(),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Harbor',
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Text(
                              "Followers",
                            ),
                            const SizedBox(height: 8.0),
                            Text(users.followers.toString())
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Text(
                              "Followings",
                            ),
                            const SizedBox(height: 8.0),
                            Text(users.following.toString())
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    width: 380,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text("Join"),
                            const SizedBox(width: 8.0),
                            const Text(": "),
                            Text(
                              join,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text("Url"),
                            const SizedBox(width: 16.0),
                            const Text(": "),
                            Text(users.htmlUrl.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        //child: Text("Profile"),
      ),
    );
  }
}