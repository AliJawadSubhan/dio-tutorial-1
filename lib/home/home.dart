import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_course/client/dio_client.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DioClient _client = DioClient();
  String input = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
              ),
            ),
          ),
          Center(
            child: FutureBuilder<User?>(
              future: _client.getUser(id: input),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? userInfo = snapshot.data;
                  if (userInfo != null) {
                    Data userData = userInfo.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(userData.avatar),
                        const SizedBox(height: 8.0),
                        Text(
                          '${userInfo.data.firstName} ${userInfo.data.lastName}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          userData.email,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
