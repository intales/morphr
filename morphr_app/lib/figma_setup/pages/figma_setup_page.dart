import 'package:flutter/material.dart';
import 'package:morphr_app/figma_setup/state/figma_setup_notifier.dart';
import 'package:morphr_app/figma_setup/widgets/figma_tree_view.dart';

class FigmaSetupPage extends StatelessWidget {
  const FigmaSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = figmaSetupManager.notifier;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 32,
          children: <Widget>[
            Text(
              "Let's download your Figma file!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter the URL here...",
                label: const Text("Figma file URL"),
              ),
              onChanged: (value) => notifier.updateFigmaFileUrl(value),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your access token here...",
                label: const Text("Figma Access token"),
              ),
              onChanged: (value) => notifier.updateFigmaAccessToken(value),
            ),
            ListenableBuilder(
              listenable: notifier.select((state) => state.document),
              builder: (context, _) {
                if (notifier.state.document == null) {
                  return const SizedBox.shrink();
                }

                return FigmaTreeView(document: notifier.state.document!);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: notifier.select((state) => state.canSubmit),
        builder: (context, _) {
          return FloatingActionButton.extended(
            onPressed:
                notifier.state.canSubmit
                    ? () => notifier.getFigmaFile().then((_) {
                      if (!context.mounted) return;
                    })
                    : null,
            label: const Text("Get Figma file"),
            icon: const Icon(Icons.save),
          );
        },
      ),
    );
  }
}
