class ChatButton{
  String buttonText, buttonType, buttonValue;
  ChatButton({this.buttonText, this.buttonType, this.buttonValue});

  factory ChatButton.fromJson(Map<String, dynamic> json) {
    return ChatButton(
      buttonText: json['buttonText'] as String,
      buttonType: json['buttonType'] as String,
      buttonValue: json['buttonValue'] as String
    );
  }
}