import 'package:bloc_test/bloc_test.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - Bloc', () {
    blocTest<ProjectBloc, ProjectState>(
      'Add a new script on NewScriptEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(),
      ),
      act: (bloc) => bloc.add(
        const NewScriptEvent(
          'playerController',
          ProjectScriptType.controller,
        ),
      ),
      expect: () => [
        const ProjectState(scripts: [
          ProjectScript(
            type: ProjectScriptType.controller,
            name: 'playerController',
            body: '',
          ),
        ]),
      ],
    );
  });
}

