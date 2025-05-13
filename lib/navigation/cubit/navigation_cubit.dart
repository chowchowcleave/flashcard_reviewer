import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { learning, createCards, decks, login, chatbot}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.login);

  void goToCreateCards() => emit(NavigationState.createCards);

  void goToLearning() => emit(NavigationState.learning);

  void goToDecks() => emit(NavigationState.decks);

  void goToLogin() => emit(NavigationState.login);

  void goToChatbot() => emit(NavigationState.chatbot);

}
