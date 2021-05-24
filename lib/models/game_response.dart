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
              .map((e) => QuestionData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class QuestionData {
  String image;
  List<String> options;
  String questionText;
  String questionId;

  QuestionData({
    this.image,
    this.options,
    this.questionText,
    this.questionId,
  });

  factory QuestionData.fromJson(json) {
    print("json in from json$json");
    return QuestionData(
      image: json["questionData"]["image"],
      questionId: json["questionId"],
      questionText: json["questionData"]["question_text"],
      options: json["questionData"]["options"] != null
          ? (json["questionData"]["options"] as List)
              .map((e) => e.toString())
              .toList()
          : null,
    );
  }
}
