part of 'chatbot_bloc.dart';

abstract class ChatbotState extends Equatable {
  const ChatbotState();

  @override
  List<Object> get props => [];
}

class ChatbotInitial extends ChatbotState {}

class ChatbotSendMessage extends ChatbotState {
  final String message;
  ChatbotSendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ChatbotMessageReceived extends ChatbotState {
  final List message;
  ChatbotMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}
