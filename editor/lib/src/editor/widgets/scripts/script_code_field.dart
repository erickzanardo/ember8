import 'package:code_text_field/code_text_field.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/scripts/bloc/scripts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class ScriptCodeField extends StatelessWidget {
  final String scriptName;

  const ScriptCodeField({
    Key? key,
    required this.scriptName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<ScriptsBloc>().state;
    final scripts = state.scripts;
    final code =
        scripts.where((script) => script.name == scriptName).first.body;
    return _Field(
        key: Key('_code_field_$scriptName'), text: code, scripName: scriptName);
  }
}

class _Field extends StatefulWidget {
  final String text;
  final String scripName;

  const _Field({
    Key? key,
    required this.text,
    required this.scripName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FieldState();
  }
}

class _FieldState extends State<_Field> {
  late CodeController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = CodeController(
      text: widget.text,
      language: javascript,
      theme: monokaiSublimeTheme,
    );

    _controller.addListener(() {
      _updateCode();
    });

    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateCode() {
    context
        .read<ScriptsBloc>()
        .add(UpdateScriptEvent(widget.scripName, _controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return CodeField(
      focusNode: _focusNode,
      controller: _controller,
    );
  }
}
