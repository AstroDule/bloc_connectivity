import 'package:bloc_connectivity/packages/network/network_bloc.dart';
import 'package:bloc_connectivity/packages/network/network_event.dart';
import 'package:bloc_connectivity/packages/network/network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Connectivity());
}

class Connectivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NetworkBloc()..add(ListenConnection()),
        child: ConnectivityShow(onLineText: 'Online', offLineText: 'Offline'),
      ),
    );
  }
}

class ConnectivityShow extends StatelessWidget {
  String onLineText = 'Online';
  String offLineText = 'Offline';

  ConnectivityShow({Key key, this.offLineText, this.onLineText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String onlineImageAddress = 'assets/drawable/online.png';
    String offlineImageAddress = 'assets/drawable/offline.png';
    return Center(
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure) {
            return buildRow(offlineImageAddress, offLineText);
          }
          if (state is ConnectionSuccess) {
            return buildRow(onlineImageAddress, onLineText);
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }

  Row buildRow(String offlineImageAddress, String text) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        offlineImageAddress,
                      )))),
          Align(
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                height: 20,
                child: Text(text,
                    style: const TextStyle(color: Colors.black, fontSize: 18))),
          ),
        ]);
  }
}
