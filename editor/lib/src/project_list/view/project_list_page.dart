import 'package:editor/src/project_list/project_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  static Route<void> route({required String userId}) {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) {
          final projectRepository = context.read<ProjectRepository>();

          return ProjectListBloc(
            userId: userId,
            projectRepository: projectRepository,
          )..add(const ProjectListRequested());
        },
        child: const ProjectListPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ProjectListView();
  }
}
