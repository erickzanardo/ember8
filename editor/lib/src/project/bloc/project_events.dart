import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

class NewProjectEvent extends ProjectEvent {
  final String userId;
  final String name;

  const NewProjectEvent({
    required this.userId,
    required this.name,
  });

  @override
  List<Object?> get props => [userId, name];
}

