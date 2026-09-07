import 'enums.dart';
import 'trainer.dart';

/// One turn in the assistant conversation.
///
/// A turn is either plain text or a trainer suggestion card; [suggestion] is
/// non-null for the latter.
class ChatMessage {
  const ChatMessage({required this.author, this.text, this.suggestion});

  final ChatAuthor author;
  final String? text;
  final TrainerSuggestion? suggestion;

  bool get isCard => suggestion != null;
}

/// A trainer proposed inside the conversation, with the reason attached.
class TrainerSuggestion {
  const TrainerSuggestion({required this.trainer, required this.reason});

  final Trainer trainer;

  /// Why this trainer was suggested — never omitted, so the surface stays
  /// explainable rather than an opaque answer.
  final String reason;
}

/// The assistant conversation the screen renders.
class ChatThread {
  const ChatThread({
    required this.assistantName,
    required this.statusLine,
    required this.dateSeparator,
    required this.messages,
    required this.quickReplies,
    required this.composerHint,
  });

  final String assistantName;
  final String statusLine;
  final String dateSeparator;
  final List<ChatMessage> messages;
  final List<String> quickReplies;
  final String composerHint;
}
