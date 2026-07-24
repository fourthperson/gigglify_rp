import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/choice_provider.dart';
import 'package:gigglify_rp/presentation/screens/page/brightness.dart';
import 'package:gigglify_rp/presentation/widget/button.dart';
import 'package:gigglify_rp/presentation/widget/list_tile.dart';

class PreferenceContent extends ConsumerStatefulWidget {
  final void Function() onSaveTap;

  const PreferenceContent({required this.onSaveTap, super.key});

  @override
  ConsumerState<PreferenceContent> createState() => _PreferenceContentState();
}

class _PreferenceContentState extends ConsumerState<PreferenceContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadChoices());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final ThemeData theme = Theme.of(context);

    final List<String> categoryTexts = [
      strings.category_any,
      strings.category_dark,
      strings.category_pun,
      strings.category_spooky,
      strings.category_christmas,
      strings.category_programming,
      strings.category_misc,
    ];

    final List<String> blacklistTexts = [
      strings.blacklist_religious,
      strings.blacklist_political,
      strings.blacklist_racist,
      strings.blacklist_sexist,
      strings.blacklist_explicit,
      strings.blacklist_nsfw,
    ];

    final AsyncValue<Choice> asyncChoices = ref.watch(choiceNotifier);

    if (asyncChoices.isLoading || asyncChoices.isRefreshing) {
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

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          strings.preferences,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: RawScrollbar(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            strings.allowed_categories,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: asyncChoices.value!.choices.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int index) {
                              final List<bool> choices =
                                  asyncChoices.value!.choices;
                              return GigListTile(
                                checked: choices[index],
                                label: categoryTexts[index],
                                onTap: (bool checked) {
                                  _saveChoices(
                                    Choice(
                                      choices: _toggleCategory(choices, index),
                                      blacklisted:
                                          asyncChoices.value!.blacklisted,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            strings.blacklisted_categories,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: blacklistTexts.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int index) {
                              final List<int> blacklist =
                                  asyncChoices.value!.blacklisted;

                              return GigListTile(
                                checked: blacklist.contains(index),
                                label: blacklistTexts[index],
                                onTap: (bool checked) {
                                  _saveChoices(
                                    Choice(
                                      choices: asyncChoices.value!.choices,
                                      blacklisted: _toggleBlacklist(
                                        blacklist,
                                        index,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          BrightnessContent(),
                          const SizedBox(height: 10),
                          GigButton(
                            label: strings.label_save,
                            onTap: widget.onSaveTap,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: MediaQuery.of(context).viewPadding.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _loadChoices() => ref.read(choiceNotifier.notifier).getChoice();

  void _saveChoices(Choice choice) =>
      ref.read(choiceNotifier.notifier).saveChoice(choice);

  List<int> _toggleBlacklist(List<int> current, int index) {
    final List<int> list = List<int>.from(current);
    final int foundIndex = list.indexWhere((item) => item == index);
    if (foundIndex != -1) {
      list.removeAt(foundIndex); // Fixed index bug (was removeAt(index))
    } else {
      list.add(index);
    }
    return list;
  }

  List<bool> _toggleCategory(List<bool> current, int index) {
    final list = List<bool>.from(current);

    if (index == 0) {
      list[0] = !list[0];
      if (list[0]) {
        for (int i = 1; i < list.length; i++) {
          list[i] = false;
        }
      }
    } else {
      list[index] = !list[index];

      final bool allOthersSelected = list
          .sublist(1)
          .every((selected) => selected == true);

      if (allOthersSelected) {
        list[0] = true;
        for (int i = 1; i < list.length; i++) {
          list[i] = false;
        }
      } else {
        list[0] = false;
      }
    }

    return list;
  }
}
