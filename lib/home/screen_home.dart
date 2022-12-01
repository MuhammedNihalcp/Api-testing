import 'dart:io';

import 'package:api_integration/data/data.dart';
import 'package:flutter/material.dart';
import '../data/chat_model/user_all_list_model.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<UserList>? userList = [];
  bool isLoading = true;
  bool activeInternetConnection = false;
  String T = '';

  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  Future<void> checkInternetConnection() async {
    try {
      final connection = await InternetAddress.lookup('google.com');
      if (connection.isNotEmpty && connection[0].rawAddress.isNotEmpty) {
        UserAllList? response = await ChatDB().getAllChat();
        if (response != null) {
          // Api error
          if (response.data != null) {
            setState(() {
              userList = response.data ?? [];
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: const [
                    Icon(
                      Icons.signal_wifi_connected_no_internet_4_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10,),
                    Text('No internet connection'),
                  ],
                ),
              ),
            );
          }
        } else {
          null;
        }
        setState(() {
          activeInternetConnection = true;
        });
      } else {
        // show network not available
        setState(() {
          isLoading = false;
          activeInternetConnection = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('API not Found!'),
          ),
        );
      }
    } on SocketException catch (_) {
      setState(() {
        activeInternetConnection = false;
        T = 'No internet connection';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnection();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: isLoading == true && activeInternetConnection == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(T),
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(userList?[index].avatar ?? ''),
                  ),
                  title: Text(userList?[index].firstName ?? ''),
                  subtitle: Text(userList?[index].email ?? ''),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: userList?.length ?? 0,
            ),
    );
  }
}
