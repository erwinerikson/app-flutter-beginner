import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Profile",
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
            coverImage(),
            Positioned(
              top: coverHeight - profileHeight / 2,
              child: profileImage(),
            ),
            Positioned(
              top: coverHeight + profileHeight / 2,
              child: bodyProfile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget coverImage() => Container(
    color: Colors.grey,
    width: double.infinity,
    height: coverHeight,
    child: Image.asset('images/cover_github.png'),
  );

  Widget profileImage() => CircleAvatar(
    radius: profileHeight/2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: const NetworkImage(
      'https://avatars.githubusercontent.com/u/57528622?v=4'
    ),
  );

  Widget bodyProfile() => Column(
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 6.0),
        child: const Text(
          "Erwin Erikson",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Harbor',
          ),
        ),
      ),
      const Text(
        "Batam, Indonesia",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'Harbor',
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        width: 300,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Followers",
                ),
                SizedBox(height: 8.0),
                Text("0")
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Followings",
                ),
                SizedBox(height: 8.0),
                Text("0")
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        width: 380,
        child: const Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Bio"),
                SizedBox(width: 8.0),
                Text(": iteba student"),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Url"),
                SizedBox(width: 8.0),
                Text(": https://github.com/erwinerikson"),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}