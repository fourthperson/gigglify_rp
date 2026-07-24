import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/presentation/screens/page/history.dart';
import 'package:gigglify_rp/presentation/screens/page/joke.dart';
import 'package:gigglify_rp/presentation/screens/page/preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController controller = PageController(initialPage: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Duration duration = Duration(milliseconds: 300);
    final Curve curve = Curves.easeInOut;
    final ThemeData theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        if (controller.page != 1) {
          await controller.animateToPage(1, duration: duration, curve: curve);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PreferenceContent(
                    onSaveTap: () => controller.animateToPage(
                      1,
                      duration: duration,
                      curve: curve,
                    ),
                  ),
                  JokeContent(
                    onHistoryTap: () => controller.animateToPage(
                      2,
                      duration: duration,
                      curve: curve,
                    ),
                    onPreferenceTap: () => controller.animateToPage(
                      0,
                      duration: duration,
                      curve: curve,
                    ),
                  ),
                  HistoryContent(
                    onBackTap: () => controller.animateToPage(
                      1,
                      duration: duration,
                      curve: curve,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      activeDotColor: theme.colorScheme.secondary,
                      dotColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
