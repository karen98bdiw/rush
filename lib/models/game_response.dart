class GameResponse {
  String playId;
  String startTime;
  List<QuestionData> questions;

  GameResponse({this.playId, this.questions});

  factory GameResponse.fromJson(json) {
    return GameResponse(
      playId: json["playId"],
      questions: json["questionsData"] != null
          ? (json["questionsData"] as List)
              .map((e) => QuestionData.fromJson(e["questionData"]))
              .toList()
          : null,
    );
  }
}

class QuestionData {
  String image;
  List<String> options;
  String questionText;

  QuestionData({
    this.image,
    this.options,
    this.questionText,
  });

  factory QuestionData.fromJson(json) {
    print("json in from json$json");
    return QuestionData(
      image: json["image"],
      questionText: json["question_text"],
      options: json["options"] != null
          ? (json["options"] as List).map((e) => e.toString()).toList()
          : null,
    );
  }
}
