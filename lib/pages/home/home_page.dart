import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/pages/home/home_bloc.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => state.when(
          loading: () => loading(context),
          loaded: () => loaded(context),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    widget.bloc.add(const HomeEvent.load());
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Widget loaded(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
