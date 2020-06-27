import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:developer' as developer;

class DialogFlowRepository {
  Future<List> dialogFlowChat(String message) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/tp-app-aff2e-ab98fc09bd7d.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response;
    try{
      response = await dialogflow.detectIntent(message);
    }
    catch(_){

    }
    return response.getListMessage();
  }
}
