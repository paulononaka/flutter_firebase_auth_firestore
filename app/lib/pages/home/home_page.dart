import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/flutfire_scaffold.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/loading.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/rounded_button.dart';
import 'package:flutter_firebase_auth_firestore/design_system/components/server_error.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/color_palette.dart';
import 'package:flutter_firebase_auth_firestore/design_system/tokens/images.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/extensions/date_extension.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => state.when(
          loading: () => loading(),
          loaded: (mostRecent) => loaded(context, mostRecent),
          error: (message) => ServerError(errorMessage: message),
        ),
      ),
    );
  }

  Widget loading() {
    widget.bloc.add(const HomeEvent.loadHome());
    return const Loading();
  }

  Widget loaded(BuildContext context, List<Order> mostRecent) {
    Size size = MediaQuery.of(context).size;
    return FlutfireScaffold(
      title: 'Flut Fire',
      logoutOnPressed: () => widget.bloc.add(const HomeEvent.logout()),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            if (mostRecent.isEmpty)
              Column(
                children: [
                  const Text("There is no recent orders",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.2, child: Images.empty),
                ],
              )
            else
              Column(
                children: [
                  const Text("Recent orders", style: TextStyle(fontWeight: FontWeight.bold)),
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 100,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        enlargeCenterPage: true,
                      ),
                      items: mostRecent.map((order) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                    const BoxDecoration(color: ColorPalette.primaryLightColor),
                                child: ListTile(
                                  trailing: const Icon(Icons.arrow_right),
                                  title: Text(order.testName),
                                  subtitle: Text(order.createdAt.mMMMdyyyy),
                                  onTap: () => widget.bloc.add(HomeEvent.tapOnTest(
                                    navigator: Navigator.of(context),
                                    order: order,
                                  )),
                                ));
                          },
                        );
                      }).toList()),
                ],
              ),
            SizedBox(height: size.height * 0.03),
            const Text("You are healthy!", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.2, child: Images.healthy),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Order new test kit",
              onPressed: () => widget.bloc.add(
                HomeEvent.tapOnOrder(navigator: Navigator.of(context)),
              ),
            ),
            RoundedButton(
              text: "All my tests",
              onPressed: () => widget.bloc.add(
                HomeEvent.tapOnTests(navigator: Navigator.of(context)),
              ),
            ),
            RoundedButton(
              text: "My profile",
              onPressed: () => widget.bloc.add(
                HomeEvent.tapOnProfile(navigator: Navigator.of(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
