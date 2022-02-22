part of 'stages_bloc.dart';

abstract class StagesEvent extends Equatable {
  const StagesEvent();
}

class NewStageEvent extends StagesEvent {
  final String projectId;
  final String name;

  const NewStageEvent({
    required this.name,
    required this.projectId,
  });

  @override
  List<Object?> get props => [projectId, name];
}

