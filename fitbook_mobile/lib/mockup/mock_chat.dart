import '../models/chat_message.dart';
import '../models/enums.dart';
import 'mock_trainers.dart';

/// Assistant-conversation fixtures.
///
/// This surface is a support assistant, not the graded ML component — trainer
/// recommendations are produced by the ML.NET recommender and live on the
/// "For you" screen.
abstract final class MockChat {
  static final thread = ChatThread(
    assistantName: 'FitBot',
    statusLine: 'Online · replies instantly',
    dateSeparator: 'Today · 14:32',
    composerHint: 'Ask FitBot anything…',
    quickReplies: const ['Compare them', 'Find cheaper', 'Show schedule'],
    messages: [
      const ChatMessage(
        author: ChatAuthor.assistant,
        text:
            'Hi Amila 👋 I\'m FitBot. Ask me about trainers, programs, or your '
            'progress.',
      ),
      const ChatMessage(
        author: ChatAuthor.user,
        text: 'Which trainer is best for weight loss?',
      ),
      const ChatMessage(
        author: ChatAuthor.assistant,
        text:
            'Based on your goal of losing 4 kg by July and your beginner '
            'level, I\'d recommend:',
      ),
      ChatMessage(
        author: ChatAuthor.assistant,
        suggestion: TrainerSuggestion(
          trainer: MockTrainers.all[1],
          reason:
              'Marko\'s HIIT + CrossFit blend burns 600–800 kcal/session and '
              'matches your 3×/week schedule. 92% of his clients hit their '
              'weight goals within 8 weeks.',
        ),
      ),
      const ChatMessage(
        author: ChatAuthor.user,
        text: 'Sounds good. Any cheaper option?',
      ),
      const ChatMessage(
        author: ChatAuthor.assistant,
        text:
            'Tarik Bešić runs outdoor cardio sessions at 35 KM/h — strong '
            'reviews for sustainable weight loss. Want me to compare them?',
      ),
    ],
  );

  static const suggestionActions = ('Book session', 'View profile');
}
