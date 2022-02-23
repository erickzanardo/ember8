import 'package:editor/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppBloc>().state.user;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: user == null
                ? ElevatedButton(
                    onPressed: () {
                      context
                          .read<AppBloc>()
                          .add(const GoogleSignInRequested());
                    },
                    child: const Text('Log with google'),
                  )
                : Row(
                    children: [
                      Text('Welcome ${user.name}'),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ///  Navigate to the project list
                        },
                        child: const Text('My projects'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AppBloc>().add(const SignOutRequested());
                        },
                        child: const Text('Log off'),
                      ),
                    ],
                  ),
          ),
          const Positioned.fill(child: Center(child: Text('Ember8!')))
        ],
      ),
    );
  }
}
