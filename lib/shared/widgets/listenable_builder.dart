import 'package:flutter/material.dart';

class ListenableBuilder extends StatefulWidget {
  const ListenableBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
  });

  final Listenable valueListenable;

  final WidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _ListenableBuilderState();
}

class _ListenableBuilderState extends State<ListenableBuilder> {
  @override
  void initState() {
    super.initState();
    widget.valueListenable.addListener(_listener);
  }

  @override
  void didUpdateWidget(ListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_listener);
      widget.valueListenable.addListener(_listener);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_listener);
    super.dispose();
  }

  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
