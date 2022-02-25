import 'package:editor/src/project_list/project_list.dart';
import 'package:editor/src/widgets/page_panel.dart';
import 'package:editor/src/widgets/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProjectListView extends StatelessWidget {
  const ProjectListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProjectListBloc>().state;

    if (state.status == ProjectListStateStatus.failure) {
      return const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    }

    if (state.status == ProjectListStateStatus.success) {
      return Scaffold(
        body: PagePanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'My projects',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Gap(sm),
                  IconButton(
                    onPressed: () async {
                      final entry = await showDialog<NewProjectFormEntry>(
                        context: context,
                        builder: (_) => const NewProjectForm(),
                      );

                      if (entry != null) {
                        context
                            .read<ProjectListBloc>()
                            .add(ProjectCreated(name: entry.name));
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const Gap(lg),
              for (final project in state.projects) ...[
                Row(
                  children: [
                    Expanded(child: Text(project.name)),
                    IconButton(
                      onPressed: () {
                        // TODO confirm deletion
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    const Gap(sm),
                    IconButton(
                      onPressed: () {
                        // TODO open project
                      },
                      icon: const Icon(Icons.create_sharp),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ],
          ),
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
