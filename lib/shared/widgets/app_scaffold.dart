import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.bottomNavigationBar,
    this.canPop = true,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: canPop ? BackButton(onPressed: () => _pop(context)) : null,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(top: false, child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  void _pop(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router?.canPop() ?? false) {
      context.pop();
      return;
    }
    Navigator.of(context).maybePop();
  }
}
