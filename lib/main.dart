import 'package:bloc_connectivity/packages/network/network_bloc.dart';
import 'package:bloc_connectivity/packages/network/network_event.dart';
import 'package:bloc_connectivity/packages/network/network_main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NetworkBloc()..add(ListenConnection()),
            child: ConnectivityShow(),
          ),
        ],
        child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLoC and Connectivity Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BLoC and Connectivity Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    String onLineText = 'Online';
    String offLineText = 'Offline';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Status of connectivity',
              style:TextStyle(color: Colors.black, fontSize: 21)
            ),
          Container(height: 20,),
          ConnectivityShow(
              onLineText: onLineText, offLineText: offLineText),
          ],
        ),
      ),
    );
  }
}
