import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'stages_event.dart';
part 'stages_state.dart';

class StagesBloc extends Bloc<StagesEvent, StagesState> {
  StagesBloc() : super(const StagesState.initial()) {
    on<NewStageEvent>(_handleNewStage);
  }

  Future<void> _handleNewStage(
    NewStageEvent event,
    Emitter<StagesState> emit,
  ) async {
    emit(
      state.copyWith(
        stages: [
          ...state.stages,
          ProjectStage(projectId: event.projectId, name: event.name),
        ],
      ),
    );
  }
}
