import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/widgets/new_project_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class EmptyProjectView extends StatelessWidget {
  const EmptyProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No project selected'),
          ElevatedButton(
            onPressed: () async {
              final newProject = await showDialog<NewProjectFormEntry>(
                context: context,
                builder: (_) => const NewProjectForm(),
              );

              if (newProject != null) {
                context.read<ProjectBloc>().add(
                      NewProjectEvent(
                        name: newProject.name,
                      ),
                    );
              }
            },
            child: const Text('New project'),
          ),
        ],
      ),
    );
  }
}
