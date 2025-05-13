import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/learning_cubit.dart';
import '../../navigation/cubit/navigation_cubit.dart';
import 'widgets.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    LearningCubit learningCubit = context.read<LearningCubit>();
    learningCubit.checkAndReloadDeck();

    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: Center(
            child: buildLearningCardView(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Again'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Hard'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Good'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Easy'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: () {
            context.read<NavigationCubit>().goToChatbot(); 
          },
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          label: const Text("Talk to AI", style: TextStyle(color: Colors.white)),
        ),

        const SizedBox(height: 50),
      ],
    );
  }

  void toggleOrAdvanceCard(LearningCubit cubit) {
    final state = cubit.state;

    if (state is CardLearningState) {
      if (state.answerIsVisible[0]) {
        cubit.nextCard();
      } else {
        cubit.toggleAnswerVisibility(0);
      }
    } else {
      cubit.toggleAnswerVisibility(0);
    }
  }
}
