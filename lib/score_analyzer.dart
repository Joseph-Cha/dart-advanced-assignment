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
  ScoreRepository repository;
  ScoreAnalyzer() : repository = ScoreRepository();

  void run() {
    while (true) {
      stdout.write(
        '메뉴를 선택하세요: \n1. 우수생 출력 \n\n2. 전체 평균 점수 출력 \n\n3. 종료\n\n입력: ',
      );
      String? intput = stdin.readLineSync();
      int? number = int.tryParse(intput!);

      if (number == 1) {
        printHighScoreOfStudent();
      } else if (number == 2) {
        printTotalAverageScore();
      } else if (number == 3) {
        print('프로그램을 종료합니다.');
        break;
      }
    }
  }

  void printHighScoreOfStudent() {
    var scores = repository.scores;
    Map<String, List<int>> datas = {};
    for (var s in scores) {
      if (datas.containsKey(s.name)) {
        datas[s.name]!.add(s.score);
      } else {
        datas[s.name] = [s.score];
      }
    }
    int highScore = 0;

    String highScoreStudentName = '';
    int count = 0;

    for (String key in datas.keys) {
      List<int>? data = datas[key];
      int totalScore = data!.fold(0, (a, b) {
        return a + b;
      });
      if (totalScore > highScore) {
        highScore = totalScore;
        highScoreStudentName = key;
        count = data.length;
      }
    }

    print(
      '우수생: $highScoreStudentName (평균 점수: ${(highScore / count).toStringAsFixed(1)})',
    );
  }

  void printTotalAverageScore() {
    var scores = repository.scores;
    int totalScore = 0;
    for (var s in scores) {
      totalScore += s.score;
    }

    print('전체 평균 점수: ${(totalScore / scores.length).toStringAsFixed(1)}');
  }
}
