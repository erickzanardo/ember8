part of 'scripts_bloc.dart';

class ScriptsState extends Equatable {

  const ScriptsState({
    required this.scripts,
  });

  const ScriptsState.initial() : this(scripts: const []);

  final List<ProjectScript> scripts;

  @override
  List<Object?> get props => [scripts];

  ScriptsState copyWith({
    List<ProjectScript>? scripts,
  }) {
    return ScriptsState(scripts: scripts ?? this.scripts);
  }
}
