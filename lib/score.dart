class Score {
  final int score;

  Score({required this.score});

  @override
  String toString() => '점수: $score';
}

class StudentScore extends Score {
  final String name;

  StudentScore({required this.name, required super.score});

  @override
  String toString() => '이름: $name, 점수: $score';
}
