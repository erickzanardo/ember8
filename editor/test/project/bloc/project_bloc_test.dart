import 'package:bloc_test/bloc_test.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - Bloc', () {
    blocTest<ProjectBloc, ProjectState>(
      'Add a new project on NewProjectEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(),
      ),
      act: (bloc) => bloc.add(
        const NewProjectEvent(name: 'new game'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(name: 'new game'),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new script on NewScriptEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(project: Project(name: '')),
      ),
      act: (bloc) => bloc.add(
        const NewScriptEvent(
          'playerController',
          ProjectScriptType.controller,
        ),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            scripts: [
              ProjectScript(
                type: ProjectScriptType.controller,
                name: 'playerController',
                body: '',
              ),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Update the script body on UpdateScriptEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          project: Project(
            name: '',
            scripts: [
              ProjectScript(
                type: ProjectScriptType.controller,
                name: 'playerController',
                body: '',
              ),
            ],
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        const UpdateScriptEvent(
          'playerController',
          'bla',
        ),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            scripts: [
              ProjectScript(
                type: ProjectScriptType.controller,
                name: 'playerController',
                body: 'bla',
              ),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new sprite on NewSpriteEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(project: Project(name: '')),
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
          project: Project(
            name: '',
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
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Changes the pixel of a sprite on PaintSpritePixelEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          project: Project(
            name: '',
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
          project: Project(
            name: '',
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
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new template on NewTemplateEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(project: Project(name: '')),
      ),
      act: (bloc) => bloc.add(
        const NewTemplateEvent('bullet'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', []),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Add a new field to the template',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', []),
            ],
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        const AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', [
                ProjectTemplateField<String>('script', 'bulletController'),
              ]),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Changes the value of a template field on UpdateFieldTemplateEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', [
                ProjectTemplateField<String>('script', 'bullet'),
              ]),
            ],
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        const UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', [
                ProjectTemplateField<String>('script', 'bulletController'),
              ]),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Removes a template field on RemoveFieldTemplateEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', [
                ProjectTemplateField<String>('script', 'bullet'),
              ]),
            ],
          ),
        ),
      ),
      act: (bloc) => bloc.add(
        const RemoveFieldTemplateEvent('bullet', 'script'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            templates: [
              ProjectTemplate('bullet', []),
            ],
          ),
        ),
      ],
    );
    blocTest<ProjectBloc, ProjectState>(
      'Adds a stage on NewStageEvent',
      build: () => ProjectBloc(
        initialState: const ProjectState(project: Project(name: '')),
      ),
      act: (bloc) => bloc.add(
        const NewStageEvent('game'),
      ),
      expect: () => [
        const ProjectState(
          project: Project(
            name: '',
            stages: [
              ProjectStage('game', []),
            ],
          ),
        ),
      ],
    );
  });
}
