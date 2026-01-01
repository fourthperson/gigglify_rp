import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/providers/choice_provider.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';

class PreferenceModal extends ConsumerStatefulWidget {
  const PreferenceModal({super.key});

  @override
  ConsumerState<PreferenceModal> createState() => _PreferenceModalState();
}

class _PreferenceModalState extends ConsumerState<PreferenceModal> {
  final List<String> categoryTexts = [
    S.current.category_any,
    S.current.category_dark,
    S.current.category_pun,
    S.current.category_spooky,
    S.current.category_christmas,
    S.current.category_programming,
    S.current.category_misc,
  ];
  final List<String> blacklistTexts = [
    S.current.blacklist_religious,
    S.current.blacklist_political,
    S.current.blacklist_racist,
    S.current.blacklist_sexist,
    S.current.blacklist_explicit,
    S.current.blacklist_nsfw,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadChoices());
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    final AsyncValue<Choice> asyncChoices = ref.watch(choiceNotifier);

    if (asyncChoices.isLoading || asyncChoices.isRefreshing) {
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

    return RawScrollbar(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                strings.preferences,
                textAlign: TextAlign.center,
                style: textRegular.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                strings.allowed_categories,
                style: textBold.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: asyncChoices.value!.choices.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) {
                  final List<bool> choices = asyncChoices.value!.choices;
                  return _CategoryItem(
                    checked: choices[index],
                    label: categoryTexts[index],
                    onTap: (bool checked) {
                      _saveChoices(
                        Choice(
                          choices: _toggleCategory(choices, index),
                          blacklisted: asyncChoices.value!.blacklisted,
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                strings.blacklisted_categories,
                style: textBold.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: blacklistTexts.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) {
                  final List<int> blacklist = asyncChoices.value!.blacklisted;

                  return _CategoryItem(
                    checked: blacklist.contains(index),
                    label: blacklistTexts[index],
                    onTap: (bool checked) {
                      _saveChoices(
                        Choice(
                          choices: asyncChoices.value!.choices,
                          blacklisted: _toggleBlacklist(blacklist, index),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  void _loadChoices() => ref.read(choiceNotifier.notifier).getChoice();

  void _saveChoices(Choice choice) =>
      ref.read(choiceNotifier.notifier).saveChoice(choice);

  List<int> _toggleBlacklist(List<int> current, int index) {
    final List<int> list = List<int>.from(current);
    final int foundIndex = list.indexWhere((item) => item == index);
    if (foundIndex != -1) {
      list.removeAt(index);
    } else {
      list.add(index);
    }
    return list;
  }

  List<bool> _toggleCategory(List<bool> current, int index) {
    final list = List<bool>.from(current);

    if (index == 0) {
      // Toggle "All": select it and clear others
      list[0] = !list[0];
      if (list[0]) {
        for (int i = 1; i < list.length; i++) {
          list[i] = false;
        }
      }
    } else {
      // Toggle a normal category
      list[index] = !list[index];

      final bool allOthersSelected = list
          .sublist(1)
          .every((selected) => selected == true);

      if (allOthersSelected) {
        // Collapse back to "All"
        list[0] = true;
        for (int i = 1; i < list.length; i++) {
          list[i] = false;
        }
      } else {
        list[0] = false; // ensure "All" is off
      }
    }

    return list;
  }
}

class _CategoryItem extends StatelessWidget {
  final bool checked;
  final String label;
  final void Function(bool) onTap;

  const _CategoryItem({
    required this.checked,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => onTap(!checked),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(vertical: -4),
      leading: Platform.isIOS
          ? CupertinoCheckbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: Colors.purple,
            )
          : Checkbox(
              value: checked,
              onChanged: (c) => onTap(c ?? false),
              activeColor: Colors.purple,
            ),
      title: Text(label, style: textRegular),
    );
  }
}
