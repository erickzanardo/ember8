import 'dart:ui';

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
    blocTest<ProjectBloc, ProjectState>(
      'Update the script body on UpdateScriptEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          scripts: [
            ProjectScript(
              type: ProjectScriptType.controller,
              name: 'playerController',
              body: '',
            ),
          ],
        ),
      ),
      act: (bloc) => bloc.add(
        const UpdateScriptEvent(
          'playerController',
          'bla',
        ),
      ),
      expect: () => [
        const ProjectState(scripts: [
          ProjectScript(
            type: ProjectScriptType.controller,
            name: 'playerController',
            body: 'bla',
          ),
        ]),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new sprite on NewSpriteEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(),
      ),
      act: (bloc) => bloc.add(
        const NewSpriteEvent(
          name: 'player',
          width: 2,
          height: 2,
        ),
      ),
      expect: () => [
        const ProjectState(
          sprites: [
            ProjectSprite(
              name: 'player',
              pixels: [
                [null, null],
                [null, null],
              ],
            ),
          ],
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Changes the pixel of a sprite on PaintSpritePixelEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          sprites: [
            ProjectSprite(
              name: 'bullet',
              pixels: [
                [null, null],
                [null, null],
              ],
            ),
            ProjectSprite(
              name: 'player',
              pixels: [
                [null, null],
                [null, null],
              ],
            )
          ],
        ),
      ),
      act: (bloc) => bloc.add(
        const PaintSpritePixelEvent(
          spriteName: 'player',
          x: 0,
          y: 0,
          color: 0,
        ),
      ),
      expect: () => [
        const ProjectState(
          sprites: [
            ProjectSprite(
              name: 'bullet',
              pixels: [
                [null, null],
                [null, null],
              ],
            ),
            ProjectSprite(
              name: 'player',
              pixels: [
                [0, null],
                [null, null],
              ],
            ),
          ],
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new template on NewTemplateEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(),
      ),
      act: (bloc) => bloc.add(
        const NewTemplateEvent('bullet'),
      ),
      expect: () => [
        const ProjectState(templates: [
          ProjectTemplate('bullet', []),
        ]),
      ],
    );
  });
}
