import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/joke_provider.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';
import 'package:ionicons_plus/ionicons_plus.dart';

class JokeContent extends ConsumerStatefulWidget {
  final void Function() onHistoryTap;
  final void Function() onPreferenceTap;

  const JokeContent({
    required this.onHistoryTap,
    required this.onPreferenceTap,
    super.key,
  });

  @override
  ConsumerState<JokeContent> createState() => _JokeContentState();
}

class _JokeContentState extends ConsumerState<JokeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadJoke());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final ThemeData theme = Theme.of(context);
    final BrandColors? brandColors = theme.extension<BrandColors>();

    final AsyncValue<Joke?> asyncJoke = ref.watch(jokeProvider);

    if (asyncJoke.isLoading || asyncJoke.isRefreshing) {
      return Scaffold(
        body: Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator(color: theme.colorScheme.primary)
              : CircularProgressIndicator(color: theme.colorScheme.primary),
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
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ),
      );
    }

    final Joke joke = asyncJoke.value!;

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
                  child: Text(joke.category, style: theme.textTheme.titleLarge),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        joke.content,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
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
                        iconData: Icons.category_outlined,
                        onTap: () => widget.onPreferenceTap(),
                        color: theme.iconTheme.color,
                      ),
                      _ActionButton(
                        iconData: Ionicons.share_social_outline,
                        iconSize: 42,
                        color:
                            brandColors?.secondaryDark ??
                            theme.colorScheme.secondary,
                        onTap: () => ref
                            .read(jokeProvider.notifier)
                            .shareJoke(joke.content),
                      ),
                      _ActionButton(
                        iconData: Icons.history_outlined,
                        onTap: () => widget.onHistoryTap(),
                        color: theme.iconTheme.color,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    strings.usage_description,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadJoke() => ref.read(jokeProvider.notifier).fetchJoke();
}

class _ActionButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color? color;
  final Function() onTap;

  const _ActionButton({
    required this.iconData,
    required this.onTap,
    this.iconSize = 32,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          size: iconSize,
          color: color ?? theme.iconTheme.color,
        ),
      ),
    );
  }
}
