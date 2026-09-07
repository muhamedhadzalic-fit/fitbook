import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.7a · FitBot assistant.
///
/// A support assistant for navigating the app. The graded ML component is the
/// explainable ML.NET recommender on [RecommendationsScreen]; this screen never
/// claims to be it, and any trainer it surfaces carries the same "why".
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final thread = Mockup.chat;

    return Scaffold(
      backgroundColor: FBColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _AppBar(thread: thread, onBack: onBack),
            Expanded(
              child: Container(
                color: FBColors.card,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  children: [
                    Center(child: _DateChip(label: thread.dateSeparator)),
                    const SizedBox(height: 10),
                    for (final m in thread.messages)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: m.isCard
                            ? _SuggestionCard(suggestion: m.suggestion!)
                            : _Bubble(message: m),
                      ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final r in thread.quickReplies)
                          _QuickReply(label: r),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _Composer(hint: thread.composerHint),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.thread, this.onBack});

  final ChatThread thread;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          FBIconButton(icon: FBIcons.back, onPressed: onBack),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [FBColors.blue, FBColors.navy],
                  ),
                  boxShadow: FBShadow.glow(FBColors.blue, opacity: 0.3),
                ),
                child: const Icon(FBIcons.bot, size: 22, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: FBColors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thread.assistantName,
                  style: FBText.titleSm.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: FBColors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      thread.statusLine,
                      style: FBText.caption.copyWith(color: FBColors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const FBIconButton(icon: FBIcons.more),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: FBRadius.all(FBRadius.pill),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Text(
        label,
        style: FBText.caption.copyWith(color: FBColors.textDim),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.author == ChatAuthor.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isUser ? FBColors.navy : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isUser ? 16 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 16),
            ),
            border: isUser ? null : Border.all(color: FBColors.cardBorder),
            boxShadow: isUser ? null : FBShadow.sm,
          ),
          child: Text(
            message.text ?? '',
            style: FBText.body.copyWith(
              color: isUser ? Colors.white : FBColors.text,
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.suggestion});

  final TrainerSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final t = suggestion.trainer;
    final (bookLabel, profileLabel) = MockChat.suggestionActions;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.88,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(color: FBColors.cardBorder),
            boxShadow: FBShadow.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FBAvatar(name: t.name, hue: t.identityHue, size: 44),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.name, style: FBText.bodyStrong),
                        const SizedBox(height: 3),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            for (final s in t.specialities) FBTag(label: s),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FBIcons.star,
                            size: 11,
                            color: FBColors.amber,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${t.rating}',
                            style: FBText.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: FBColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        MockChrome.hourlyRate(t.hourlyRate),
                        style: FBText.label.copyWith(
                          fontWeight: FontWeight.w700,
                          color: FBColors.navy,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              // "Why" is mandatory on every suggestion — a recommendation the
              // user cannot interrogate is not a recommendation.
              Text.rich(
                TextSpan(
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textMid,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text: MockChrome.whyPrefix,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: FBColors.blue,
                      ),
                    ),
                    TextSpan(text: suggestion.reason),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FBButton(
                      label: bookLabel,
                      height: 36,
                      fontSize: 12,
                      radius: FBRadius.control,
                    ),
                  ),
                  const SizedBox(width: 6),
                  FBButton(
                    label: profileLabel,
                    kind: FBButtonKind.outline,
                    height: 36,
                    fontSize: 12,
                    radius: FBRadius.control,
                    expand: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickReply extends StatelessWidget {
  const _QuickReply({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: FBRadius.all(FBRadius.pill),
        border: Border.all(color: FBColors.blue.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: FBText.label.copyWith(color: FBColors.blue)),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: FBColors.cardBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          child: Row(
            children: [
              const FBIconButton(icon: FBIcons.plus, iconSize: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: FBColors.card,
                    borderRadius: FBRadius.all(FBRadius.pill),
                    border: Border.all(color: FBColors.cardBorder),
                  ),
                  child: Text(
                    hint,
                    style: FBText.bodyLg.copyWith(color: FBColors.textDim),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: FBColors.blue,
                  shape: BoxShape.circle,
                  boxShadow: FBShadow.glow(FBColors.blue, opacity: 0.35),
                ),
                child: const Icon(FBIcons.send, size: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
