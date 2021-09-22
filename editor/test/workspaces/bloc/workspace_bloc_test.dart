import 'package:bloc_test/bloc_test.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:editor/src/workspaces/bloc/workspace_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Workspace - Bloc', () {
    group('OpenEditorEvent', () {
      blocTest<WorkspaceBloc, WorkspaceState>(
        'Opens a new script on OpenEditorEvent',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(),
        ),
        act: (bloc) => bloc.add(const OpenEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(
            openEditors: ['playerController'],
            currentEditor: 'playerController',
          ),
        ],
      );
      blocTest<WorkspaceBloc, WorkspaceState>(
        'makes it the current one if it is already open',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: ['playerController']),
        ),
        act: (bloc) => bloc.add(const OpenEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(
            openEditors: ['playerController'],
            currentEditor: 'playerController',
          ),
        ],
      );
    });

    group('CloseEditorEvent', () {
      blocTest<WorkspaceBloc, WorkspaceState>(
        'removes the script',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: ['playerController']),
        ),
        act: (bloc) => bloc.add(const CloseEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(openEditors: []),
        ],
      );
      blocTest<WorkspaceBloc, WorkspaceState>(
        'does nothing if there is no script with that name',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: []),
        ),
        act: (bloc) => bloc.add(const CloseEditorEvent('playerController')),
        expect: () => [],
      );
      blocTest<WorkspaceBloc, WorkspaceState>(
        'if closing a selected tab, we need to the last remaining one',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(
            openEditors: ['playerController', 'playerMovement'],
            currentEditor: 'playerController',
          ),
        ),
        act: (bloc) => bloc.add(const CloseEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(
              openEditors: ['playerMovement'], currentEditor: 'playerMovement'),
        ],
      );
      blocTest<WorkspaceBloc, WorkspaceState>(
        'if closing a selected tab, and there is no more remaining, clear the open one',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: ['playerController']),
        ),
        act: (bloc) => bloc.add(const CloseEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(openEditors: [], currentEditor: ''),
        ],
      );
    });
    group('SelectEditorEvent', () {
      blocTest<WorkspaceBloc, WorkspaceState>(
        'selects the script',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: ['playerController']),
        ),
        act: (bloc) => bloc.add(const SelectEditorEvent('playerController')),
        expect: () => [
          const WorkspaceState(
            openEditors: ['playerController'],
            currentEditor: 'playerController',
          ),
        ],
      );
      blocTest<WorkspaceBloc, WorkspaceState>(
        'does nothing if there is no script with that name',
        build: () => WorkspaceBloc(
          initialState: const WorkspaceState(openEditors: []),
        ),
        act: (bloc) => bloc.add(const SelectEditorEvent('playerController')),
        expect: () => [],
      );
    });
  });
}
