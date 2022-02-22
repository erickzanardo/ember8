part of 'stages_bloc.dart';

class StagesState extends Equatable {
  const StagesState({
    required this.stages,
  });
  
  const StagesState.initial() : this(stages: const []);

  final List<ProjectStage> stages;

  @override
  List<Object> get props => [stages];

  StagesState copyWith({
    List<ProjectStage>? stages,
  }) {
    return StagesState(stages: stages ?? this.stages);
  }
}
