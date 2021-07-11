import 'package:flutter_clean_architecture_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    // NOTE: the numbers api number can be return as an Integer, Double or null

    return NumberTriviaModel(
      text: json['text'],
      number:
          json['number'] == null ? json['number'] : (json['number']).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "number": number,
    };
  }
}
