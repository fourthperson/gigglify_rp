import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/history_provider.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
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

    dateFormat = _loadDateFormat(context);

    final AsyncValue<List<Joke>> asyncHistory = ref.watch(historyProvider);

    if (asyncHistory.isLoading || asyncHistory.isRefreshing) {
      return SafeArea(
        child: SizedBox(
          height: 150,
          child: Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (asyncHistory.value == null) {
      return SafeArea(
        child: _Info(
          iconData: Ionicons.warning_outline,
          iconColor: Colors.red,
          message: strings.history_error,
        ),
      );
    }

    if (asyncHistory.value != null && asyncHistory.value!.isEmpty) {
      return SafeArea(
        child: _Info(
          iconData: Ionicons.cube_outline,
          iconColor: Colors.black,
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
                  style: textBold.copyWith(fontSize: 20),
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
  final Color iconColor;
  final String message;

  const _Info({
    required this.iconData,
    required this.iconColor,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: iconColor),
            Text(message, style: textRegular.copyWith(fontSize: 16)),
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(joke.content, style: textMedium.copyWith(fontSize: 16)),
            Row(
              children: [
                Text(
                  joke.category.toUpperCase(),
                  style: textLight.copyWith(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  dateFormat == null
                      ? joke.time.toString()
                      : dateFormat!.format(
                          DateTime.fromMillisecondsSinceEpoch(joke.time),
                        ),
                  style: textRegular.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
