import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile.dart';
import 'api/api_service.dart';
import 'detail.dart';
import 'model/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<User>? users = snapshot.data;
            return _buildView(users);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildView(List<User>? users) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return _buildListView(users);
          } else if (constraints.maxWidth <= 1200) {
            return _buildGridView(gridCount: 2, users);
          } else {
            return _buildGridView(gridCount: 4, users);
          }
        },
      ),
    );
  }


  Widget _buildListView(List<User>? users) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text(
            "GitHub's User",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Bristle',
            ),
          ),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            GestureDetector(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              User? user = users?[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Detail(user: user.login, api: apiService);
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  image: DecorationImage(
                                    image: NetworkImage(user!.avatarUrl),
                                  ),
                                ),
                              ),

                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(user.login),
                                  Text(user.htmlUrl),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: users?.length,
          ),
        ),

      ),
    );
  }


  Widget _buildGridView(List<User>? users, {required int gridCount}) {

    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text(
            "GitHub's User",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Bristle',
            ),
          ),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            GestureDetector(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GridView.count(
            crossAxisCount: gridCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 16/6,
            children: users!.map((user) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Detail(user: user.login, api: apiService);
                  }));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                image: DecorationImage(
                                  image: NetworkImage(user.avatarUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(user.login),
                                Text(user.htmlUrl),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}