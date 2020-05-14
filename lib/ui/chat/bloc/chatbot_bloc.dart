import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tp_app/ui/chat/repository/DialogFlowRepository.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  DialogFlowRepository dialogFlowRepository;

  ChatbotBloc(this.dialogFlowRepository);
  @override
  ChatbotState get initialState => ChatbotInitial();

  @override
  Stream<ChatbotState> mapEventToState(
    ChatbotEvent event,
  ) async* {
    if (event is SendMessage) {
      print(event.message);
      yield* _mapSendMessage(event.message);
    }
  }

  Stream<ChatbotState> _mapSendMessage(String message) async* {
    yield ChatbotSendMessage(message);
    List receivedMessage;
    await this.dialogFlowRepository.dialogFlowChat(message).then((value) {
      receivedMessage = value;
    });
    yield ChatbotMessageReceived(receivedMessage);
  }
}
