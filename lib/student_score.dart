import 'package:dart_advanced_assignment/score.dart';

class StudentScore extends Score {
  final String name;

  StudentScore({required this.name, required super.score});

  @override
  String toString() => '이름: $name, 점수: $score';
}
