import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_workspace/database/apis.dart';
import 'package:flutter_workspace/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  FutureBuilder<List<TransactionDetails>>(
                      future: fetchAlbum(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Image.network(
                                      snapshot.data![index].avatar.toString()),
                                ),
                                title: Text(snapshot.data![index].name.toString()),
                                trailing:
                                Text(snapshot.data![index].amount.toString()),
                                subtitle: Text(snapshot.data![index].date.toString()),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                ],
      ),
            ),
          ),
        );
  }

  Future<List<TransactionDetails>> fetchAlbum() async {
    final response = await http.get(Uri.parse(ApiConnections.USER_LIST));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => TransactionDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}