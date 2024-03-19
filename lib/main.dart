import 'package:app1flutter/pages/home.dart';
import 'package:app1flutter/pages/status.dart';
import 'package:app1flutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Material app",
        initialRoute: 'status',
        routes: {
          'home':(_)=> HomePage(),
          'status':(_)=>StatusPage()
        },
      ),
    );
  }
}
