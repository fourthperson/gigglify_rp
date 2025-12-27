import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/providers/joke_provider.dart';
import 'package:gigglify_rp/presentation/screens/modal/history.dart';
import 'package:gigglify_rp/presentation/screens/modal/preferences.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';
import 'package:ionicons/ionicons.dart';

import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadJoke());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    final AsyncValue<Joke?> asyncJoke = ref.watch(jokeProvider);

    if (asyncJoke.isLoading || asyncJoke.isRefreshing) {
      return Scaffold(
        body: Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(),
        ),
      );
    }

    if (asyncJoke.value == null || asyncJoke.hasError) {
      return Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _loadJoke(),
          child: Center(
            child: Text(
              strings.usage_description1,
              style: textBold.copyWith(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _loadJoke(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    asyncJoke.value?.category ?? '',
                    style: textBold.copyWith(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        asyncJoke.value?.content ?? '',
                        textAlign: TextAlign.center,
                        style: textMedium.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionButton(
                        iconData: Ionicons.settings_outline,
                        onTap: () => _modal(const PreferenceModal()),
                      ),
                      _ActionButton(
                        iconData: Ionicons.share_social_outline,
                        iconSize: 42,
                        color: Colors.purple,
                        onTap: () => SharePlus.instance.share(
                          ShareParams(text: asyncJoke.value?.content ?? ''),
                        ),
                      ),
                      _ActionButton(
                        iconData: Ionicons.time_outline,
                        onTap: () => _modal(const HistoryModal()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    strings.usage_description,
                    style: textLight.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadJoke() => ref.read(jokeProvider.notifier).fetchJoke();

  void _modal(Widget content) {
    content = Material(child: content);
    if (Platform.isIOS) {
      showCupertinoModalBottomSheet(context: context, builder: (_) => content);
    } else {
      showMaterialModalBottomSheet(context: context, builder: (_) => content);
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color color;
  final Function() onTap;

  const _ActionButton({
    required this.iconData,
    required this.onTap,
    this.iconSize = 32,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(iconData, size: iconSize, color: color),
      ),
    );
  }
}
