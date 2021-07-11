import 'package:counter_app/bloc/counter_bloc.dart';
import 'package:counter_app/counter_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Counter app using flutter bloc"),
          ),
          body: BlocProvider<CounterBloc>(
            create: (context) => CounterBloc(),
            child: CounterBody(),
          )),
    );
  }
}

class CounterBody extends StatelessWidget {
  const CounterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  state.value.toString(),
                  style: Theme.of(context).textTheme.headline2,
                );

                // if (state is CounterInitial) {
                // return Text(
                //   state.value.toString(),
                //   style: Theme.of(context).textTheme.headline2,
                // );
                // } else if (state is CounterIncrement) {
                //   return Text(
                //     state.value.toString(),
                //     style: Theme.of(context).textTheme.headline2,
                //   );
                // } else if (state is CounterDecrement) {
                //   return Text(
                //     state.value.toString(),
                //     style: Theme.of(context).textTheme.headline2,
                //   );
                // }

                // throw UnimplementedError();
              },
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    counterBloc.add(IncrementEvent());
                  },
                  child: Icon(Icons.arrow_upward),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // counterCubit.decreament();
                    counterBloc.add(DecrementEvent());
                  },
                  child: Icon(Icons.arrow_downward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
