import 'package:deposit/deposit.dart';
import 'package:deposit_firestore/deposit_firestore.dart';
import 'package:repository/repository.dart';

/// {@template project_repository}
///
/// Repository to access [Project]s
///
/// {@endtemplate}
class ProjectRepository extends Deposit<Project, String> {

  /// {@macro project_repository}
  ProjectRepository({ required FirestoreDepositAdapter adapter })
      : super('projects', Project.fromJson, adapter: adapter);

  /// Returns all the projects that a user have
  Future<List<Project>> fetchUserProjects(String userId) {
    return by('userId', userId);
  }
}
