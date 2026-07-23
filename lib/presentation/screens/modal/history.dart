import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/history_provider.dart';
import 'package:intl/intl.dart';
import 'package:ionicons_plus/ionicons_plus.dart';
import 'package:share_plus/share_plus.dart';

class HistoryModal extends ConsumerStatefulWidget {
  const HistoryModal({super.key});

  @override
  ConsumerState<HistoryModal> createState() => _HistoryModalState();
}

class _HistoryModalState extends ConsumerState<HistoryModal> {
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadHistory());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final ThemeData theme = Theme.of(context);

    dateFormat = _loadDateFormat(context);

    final AsyncValue<List<Joke>> asyncHistory = ref.watch(historyProvider);

    if (asyncHistory.isLoading || asyncHistory.isRefreshing) {
      return SafeArea(
        child: SizedBox(
          height: 150,
          child: Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator(color: theme.colorScheme.primary)
                : CircularProgressIndicator(color: theme.colorScheme.primary),
          ),
        ),
      );
    }

    if (asyncHistory.value == null) {
      return SafeArea(
        child: _Info(
          iconData: Ionicons.warning_outline,
          iconColor: theme.colorScheme.error,
          message: strings.history_error,
        ),
      );
    }

    if (asyncHistory.value != null && asyncHistory.value!.isEmpty) {
      return SafeArea(
        child: _Info(
          iconData: Ionicons.cube_outline,
          iconColor: theme.iconTheme.color,
          message: strings.history_empty,
        ),
      );
    }

    return SafeArea(
      child: RawScrollbar(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text(
                  strings.history,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: asyncHistory.value?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final Joke joke = asyncHistory.value![index];
                  return _HistoryItem(
                    joke: joke,
                    dateFormat: dateFormat,
                    onTap: () => SharePlus.instance.share(
                      ShareParams(text: joke.content),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadHistory() => ref.read(historyProvider.notifier).fetchHistory();

  DateFormat _loadDateFormat(BuildContext context) {
    final DateFormat format = DateFormat.yMd(
      Localizations.localeOf(context).languageCode,
    );
    final bool is24h = MediaQuery.of(context).alwaysUse24HourFormat;
    return DateFormat('${format.pattern} ${is24h ? 'HH:mm:ss' : 'h:m:s a'}');
  }
}

class _Info extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final String message;

  const _Info({required this.iconData, required this.message, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: iconColor ?? theme.iconTheme.color),
            Text(message, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final Joke joke;
  final Function() onTap;
  final DateFormat? dateFormat;

  const _HistoryItem({
    required this.joke,
    required this.onTap,
    this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(joke.content, style: theme.textTheme.bodyMedium),
            Row(
              children: [
                Text(
                  joke.category.toUpperCase(),
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  dateFormat == null
                      ? joke.time.toString()
                      : dateFormat!.format(
                          DateTime.fromMillisecondsSinceEpoch(joke.time),
                        ),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
