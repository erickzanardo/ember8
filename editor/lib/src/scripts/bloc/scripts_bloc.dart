import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'scripts_events.dart';
part 'scripts_state.dart';

class ScriptsBloc extends Bloc<ScriptsEvent, ScriptsState> {
  ScriptsBloc() : super(const ScriptsState.initial()) {
    on<NewScriptEvent>(_handleNewScript);
    on<UpdateScriptEvent>(_handleUpdateScript);
  }

  Future<void> _handleNewScript(
    NewScriptEvent event,
    Emitter<ScriptsState> emit,
  ) async {
    emit(
      state.copyWith(
        scripts: [
          ...state.scripts,
          ProjectScript(
            projectId: event.projectId,
            type: event.type,
            name: event.name,
            body: '',
          ),
        ],
      ),
    );
  }

  Future<void> _handleUpdateScript(
    UpdateScriptEvent event,
    Emitter<ScriptsState> emit,
  ) async {
    emit(
      state.copyWith(
        scripts: state.scripts.map(
          (script) {
            if (script.name == event.name) {
              return script.copyWith(body: event.code);
            } else {
              return script;
            }
          },
        ).toList(),
      ),
    );
  }
}
