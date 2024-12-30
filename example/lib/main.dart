import 'package:morphr/morphr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  const token = String.fromEnvironment("TOKEN");
  const fileKey = String.fromEnvironment("FILE_KEY");

  await FigmaService.instance.initialize(
    accessToken: token,
    fileId: fileKey,
  );

  runApp(const FigmaTestApp());
}

class FigmaTestApp extends StatelessWidget {
  const FigmaTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
      ),
      home: Builder(
        builder: (context) {
          return const Scaffold(
            appBar: MyAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  MyStatsRow(),
                  MyRecentActivity(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: FigmaComponent(
        componentId: "app_bar",
        overrides: [
          FigmaOverride(
            nodeId: "search_text",
            properties: {
              FigmaProperties.isTextField: true,
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class MyStatsRow extends StatelessWidget {
  const MyStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const FigmaComponent(
      componentId: "stats_row",
    );
  }
}

class RecentActivity {
  final String title;
  final String subtitile;

  const RecentActivity({
    required this.title,
    required this.subtitile,
  });
}

class MyRecentActivity extends StatelessWidget {
  const MyRecentActivity({super.key});

  static List<RecentActivity> get activities => List.generate(
        10,
        (i) => RecentActivity(
          title: "Title ${i + 1}",
          subtitile: "subtitile ${i + 1}",
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FigmaComponent(
      componentId: "recent_activity",
      overrides: [
        FigmaOverride(
          nodeId: "recent_activity_list",
          properties: {
            FigmaProperties.scrollableContent: ScrollableContent(
              itemCount: activities.length,
              itemBuilder: (context, index) => RecentActivityItem(
                activity: activities[index],
              ),
            ),
          },
        ),
      ],
    );
  }
}

class RecentActivityItem extends StatelessWidget {
  const RecentActivityItem({
    required this.activity,
    super.key,
  });

  final RecentActivity activity;

  @override
  Widget build(BuildContext context) {
    return FigmaComponent(
      componentId: "recent_activity_item",
      overrides: [
        FigmaOverride(
          nodeId: "recent_activity_title",
          properties: {
            FigmaProperties.text: activity.title,
          },
        ),
        FigmaOverride(
          nodeId: "recent_activity_subtitle",
          properties: {
            FigmaProperties.text: activity.subtitile,
          },
        ),
      ],
    );
  }
}
