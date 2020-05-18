import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:developer' as developer;

class DialogFlowRepository {
  Future<List> dialogFlowChat(String message) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/tp-app-aff2e-firebase-adminsdk-v0eyn-a5f556b175.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(message);
    developer.log(response.getMessage(), name: "DialogFlowRepsitory");
    return response.getListMessage();
  }
}
