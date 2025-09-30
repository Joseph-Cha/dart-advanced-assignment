import 'dart:io';

import 'package:dart_advanced_assignment/score_analyzer.dart';
import 'package:dart_advanced_assignment/score_repository.dart';

void main(List<String> arguments) {
  stdout.write('실행할 과제를 선택해 주세요. \n1: 학생 점수 정보 출력\n2: 학생 점수 분석\n');
  String? intput = stdin.readLineSync();
  int? number = int.tryParse(intput!);

  if (number == 1) {
    ScoreRepository scoreRepository = ScoreRepository();
    scoreRepository.run();
  } else if (number == 2) {
    ScoreAnalyzer analyzer = ScoreAnalyzer();
    analyzer.run();
  } else {
    throw Exception('1~2번 숫자를 입력해 주세요.');
  }
}
