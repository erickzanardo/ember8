import 'package:bloc_test/bloc_test.dart';
import 'package:editor/src/editor/bloc/editor_bloc.dart';
import 'package:editor/src/editor/bloc/editor_events.dart';
import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Editor - Bloc', () {
    blocTest<EditorBloc, EditorState>(
      'Changes the current tab on SelectTabEvent',
      build: () => EditorBloc(
        initialState: const EditorState(currentTab: EditorTab.stages),
      ),
      act: (bloc) => bloc.add(const SelectTabEvent(EditorTab.sprites)),
      expect: () => [
        const EditorState(currentTab: EditorTab.sprites),
      ],
    );

    group('OpenScriptEvent', () {
      blocTest<EditorBloc, EditorState>(
        'Opens a new script on OpenScriptEvent',
        build: () => EditorBloc(
          initialState: const EditorState(),
        ),
        act: (bloc) => bloc.add(const OpenScriptEvent('playerController')),
        expect: () => [
          const EditorState(
            openScripts: ['playerController'],
            currentOpenScript: 'playerController',
          ),
        ],
      );
      blocTest<EditorBloc, EditorState>(
        'makes it the current one if it is already open',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: ['playerController']),
        ),
        act: (bloc) => bloc.add(const OpenScriptEvent('playerController')),
        expect: () => [
          const EditorState(
            openScripts: ['playerController'],
            currentOpenScript: 'playerController',
          ),
        ],
      );
    });

    group('CloseScriptEvent', () {
      blocTest<EditorBloc, EditorState>(
        'removes the script',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: ['playerController']),
        ),
        act: (bloc) => bloc.add(const CloseScriptEvent('playerController')),
        expect: () => [
          const EditorState(openScripts: []),
        ],
      );
      blocTest<EditorBloc, EditorState>(
        'does nothing if there is no script with that name',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: []),
        ),
        act: (bloc) => bloc.add(const CloseScriptEvent('playerController')),
        expect: () => [],
      );
      blocTest<EditorBloc, EditorState>(
        'if closing a selected tab, we need to the last remaining one',
        build: () => EditorBloc(
          initialState: const EditorState(
            openScripts: ['playerController', 'playerMovement'],
            currentOpenScript: 'playerController',
          ),
        ),
        act: (bloc) => bloc.add(const CloseScriptEvent('playerController')),
        expect: () => [
          const EditorState(
              openScripts: ['playerMovement'],
              currentOpenScript: 'playerMovement'),
        ],
      );
      blocTest<EditorBloc, EditorState>(
        'if closing a selected tab, and there is no more remaining, clear the open one',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: ['playerController']),
        ),
        act: (bloc) => bloc.add(const CloseScriptEvent('playerController')),
        expect: () => [
          const EditorState(openScripts: [], currentOpenScript: ''),
        ],
      );
    });
    group('SelectScriptEvent', () {
      blocTest<EditorBloc, EditorState>(
        'selects the script',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: ['playerController']),
        ),
        act: (bloc) => bloc.add(const SelectScriptEvent('playerController')),
        expect: () => [
          const EditorState(
            openScripts: ['playerController'],
            currentOpenScript: 'playerController',
          ),
        ],
      );
      blocTest<EditorBloc, EditorState>(
        'does nothing if there is no script with that name',
        build: () => EditorBloc(
          initialState: const EditorState(openScripts: []),
        ),
        act: (bloc) => bloc.add(const SelectScriptEvent('playerController')),
        expect: () => [],
      );
    });
  });
}
