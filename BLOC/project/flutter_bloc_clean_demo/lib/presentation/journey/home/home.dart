import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_flutter_app/presentation/journey/home/bloc/home_bloc.dart';
import 'package:tinder_flutter_app/presentation/journey/home/bloc/home_event.dart';
import 'package:tinder_flutter_app/presentation/journey/home/bloc/home_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BlocBuilder(
                cubit: homeBloc,
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  } else if (state is LoadedState) {
                    return Text(
                      state.userData.results.first.name.first,
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Text(
                      "Home Page",
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ),
            FlatButton(
                onPressed: () {
                  homeBloc.add(LoadUserDataEvent());
                },
                child: Text(
                  "Tap to Load",
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.w600),
        ),
      );
}
