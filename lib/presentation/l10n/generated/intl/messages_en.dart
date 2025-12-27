// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "allowed_categories": MessageLookupByLibrary.simpleMessage(
      "Allowed categories",
    ),
    "app_name": MessageLookupByLibrary.simpleMessage("Gigglify"),
    "blacklist_explicit": MessageLookupByLibrary.simpleMessage("Explicit"),
    "blacklist_nsfw": MessageLookupByLibrary.simpleMessage("NSFW"),
    "blacklist_political": MessageLookupByLibrary.simpleMessage("Political"),
    "blacklist_racist": MessageLookupByLibrary.simpleMessage("Racist"),
    "blacklist_religious": MessageLookupByLibrary.simpleMessage("Religious"),
    "blacklist_sexist": MessageLookupByLibrary.simpleMessage("Sexist"),
    "blacklisted_categories": MessageLookupByLibrary.simpleMessage(
      "Blacklisted categories",
    ),
    "category_any": MessageLookupByLibrary.simpleMessage("Any"),
    "category_christmas": MessageLookupByLibrary.simpleMessage("Christmas"),
    "category_dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "category_misc": MessageLookupByLibrary.simpleMessage("Miscellaneous"),
    "category_programming": MessageLookupByLibrary.simpleMessage("Programming"),
    "category_pun": MessageLookupByLibrary.simpleMessage("Pun"),
    "category_spooky": MessageLookupByLibrary.simpleMessage("Spooky"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "history_empty": MessageLookupByLibrary.simpleMessage("Empty"),
    "history_error": MessageLookupByLibrary.simpleMessage(
      "Error Loading History",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "usage_description": MessageLookupByLibrary.simpleMessage(
      "Press anywhere on the screen for another joke",
    ),
    "usage_description1": MessageLookupByLibrary.simpleMessage(
      "Tap the screen to load a joke",
    ),
  };
}
