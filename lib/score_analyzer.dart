/*

### 1. 학생들 중 우수생을 출력하는 기능

[ 설명 ]

- 사용자가 `1`을 입력했을 경우, 가장 높은 평균 점수를 가진 학생(우수생)을 찾아 출력합니다.

### 2. 전체 평균 점수를 출력하는 기능

[ 설명 ]

- 사용자가 `2`를 입력했을 경우, 전체 학생들의 모든 점수를 합산하여 평균 점수를 계산하고 출력합니다.

### 3. 자유롭게 여러분만의 기능을 추가해보세요!

**[ 설명 ]**

- 단, **`필수 기능을 반드시 먼저 완성`**한 뒤에 꿈을 펼쳐봅시다.
 */

import 'dart:io';
import 'package:dart_advanced_assignment/score_repository.dart';

class ScoreAnalyzer {
  final ScoreRepository repository;

  ScoreAnalyzer() : repository = ScoreRepository();

  void run() {
    while (true) {
      _displayMenu();
      final input = stdin.readLineSync();
      final menuChoice = int.tryParse(input ?? '');

      if (!_handleMenuChoice(menuChoice)) {
        break;
      }
    }
  }

  void _displayMenu() {
    stdout.write('메뉴를 선택하세요: \n1. 우수생 출력 \n\n2. 전체 평균 점수 출력 \n\n3. 종료\n\n입력: ');
  }

  bool _handleMenuChoice(int? choice) {
    switch (choice) {
      case 1:
        printTopStudent();
        return true;
      case 2:
        printOverallAverage();
        return true;
      case 3:
        print('프로그램을 종료합니다.');
        return false;
      default:
        return true;
    }
  }

  void printTopStudent() {
    final studentAverages = groupScoresByStudent();

    if (studentAverages.isEmpty) return;

    final topStudent = findTopStudent(studentAverages);
    print(
      '우수생: ${topStudent['name']} (평균 점수: ${topStudent['average'].toStringAsFixed(1)})\n',
    );
  }

  Map<String, List<int>> groupScoresByStudent() {
    final studentScores = <String, List<int>>{};

    for (final score in repository.scores) {
      studentScores.putIfAbsent(score.name, () => []).add(score.score);
    }

    return studentScores;
  }

  Map<String, dynamic> findTopStudent(Map<String, List<int>> studentScores) {
    String topName = '';
    double topAverage = 0.0;

    for (final entry in studentScores.entries) {
      final average = entry.value.reduce((a, b) => a + b) / entry.value.length;
      if (average > topAverage) {
        topAverage = average;
        topName = entry.key;
      }
    }

    return {'name': topName, 'average': topAverage};
  }

  void printOverallAverage() {
    final scores = repository.scores;

    if (scores.isEmpty) {
      print('점수 데이터가 없습니다.');
      return;
    }

    final totalScore = scores.fold<int>(0, (sum, s) => sum + s.score);
    final average = totalScore / scores.length;

    print('전체 평균 점수: ${average.toStringAsFixed(1)}\n');
  }
}
