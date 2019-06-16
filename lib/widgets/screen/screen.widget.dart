import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagrao/widgets/loader/loader.widget.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';
import 'package:instagrao/widgets/screen/screen.event.dart';
import 'package:instagrao/widgets/screen/screen.state.dart';

class Screen extends StatefulWidget {
  const Screen({
    @required this.bloc,
    @required this.children,
  });

  final ScreenBloc bloc;
  final List<Widget> children;

  @override
  State<Screen> createState() => _Screen();
}

class _Screen extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenEvent, ScreenState>(
      bloc: widget.bloc,
      builder: (
        BuildContext context,
        ScreenState state,
      ) {
        final children = widget.children;

        if (state.isLoading) {
          children.add(Loader());
        }

        return Stack(
          children: children,
        );
      },
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
