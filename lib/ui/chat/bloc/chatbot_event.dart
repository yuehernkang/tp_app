part of 'chatbot_bloc.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();
  List<Object> get props => null;
}

class SendMessage extends ChatbotEvent {
  final String message;

  SendMessage(this.message);
  List<Object> get props => [message];
}
