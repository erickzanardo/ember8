import 'package:auth_repository/auth_repository.dart';
import 'package:editor/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ember8App extends StatelessWidget {
  const Ember8App({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(authRepository: _authRepository),
        child: const MaterialApp(
          home: Home(),
        ),
      ),
    );
  }
}
