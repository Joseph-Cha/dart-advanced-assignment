/* 
### **1. Score와 StudentScore 클래스를 구성하기**

[ 설명 ] 

- 점수를 표현하는 `Score` 클래스를 정의하고, 이를 상속받아 학생의 정보를 포함하는 `StudentScore` 클래스를 구현합니다.
- `Score` 클래스는 단순히 점수만 출력하지만, `StudentScore` 클래스는 학생 이름과 과목까지 포함하여 더 구체적인 정보를 출력합니다.


### **2. 파일로부터 데이터 읽어오기 기능**

- [ 설명 ]
    - 프로그램 시작 시 `students.txt` 파일에서 학생들 점수 목록을 받아옵니다.
        - **students.txt**
            
            ```dart
            홍길동,90
            김철수,80
            ```
            
    - 파일은 CSV 형식으로, 한 줄에 `이름,점수` 형태의 데이터가 저장되어 있습니다.

### **3.  사용자로부터 입력 받아 학생 점수 확인 기능**

- 설명
    - 프로그램 시작 시 사용자로부터 과목 정보를 입력 받습니다.

### **4.  프로그램 종료 후, 결과를 파일에 저장하는 기능**

- 설명
    - 3번 기능 이후, 결과를 파일에 저장하며 프로그램을 종료합니다.
    - result.txt 파일을 생성해서 여기에 결과를 저장해주세요.
    - result.txt 파일에 `“이름: 홍길동, 점수: 90”`형태로 저장해주시면 됩니다.
*/

import 'dart:io';
import 'package:dart_advanced_assignment/score.dart';

class ScoreRepository {
  final List<StudentScore> _scores;
  final String _scriptDir = File(
    Platform.script.toFilePath(),
  ).parent.parent.path;

  List<StudentScore> get scores => _scores;

  ScoreRepository() : _scores = [] {
    _scores.addAll(_loadScores());
  }

  List<StudentScore> _loadScores() {
    try {
      final filePath = '$_scriptDir/data/students.txt';
      final file = File(filePath);
      final lines = file.readAsLinesSync();

      return lines.map((line) => _parseStudentScore(line)).toList();
    } catch (e) {
      throw FileSystemException('학생 데이터를 불러오는 데 실패했습니다: $e');
    }
  }

  StudentScore _parseStudentScore(String line) {
    final parts = line.split(',');
    if (parts.length != 2) {
      throw FormatException('잘못된 데이터 형식: $line');
    }
    return StudentScore(name: parts[0], score: int.parse(parts[1]));
  }

  void _saveToFile(String filePath, String content) {
    try {
      final file = File(filePath);
      file.writeAsStringSync(content);
      print("저장이 완료되었습니다.");
    } catch (e) {
      print("저장에 실패했습니다: $e");
    }
  }

  void run() {
    final selectedScore = _getStudentScoreFromUser();
    final result = '이름: ${selectedScore.name}, 점수: ${selectedScore.score}';
    print(result);

    final resultFilePath = '$_scriptDir/data/result.txt';
    _saveToFile(resultFilePath, result);
  }

  StudentScore _getStudentScoreFromUser() {
    while (true) {
      stdout.write('어떤 학생의 통계를 확인하시겠습니까? ');
      final input = stdin.readLineSync();

      try {
        return _scores.firstWhere((s) => s.name == input);
      } catch (e) {
        print('잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.');
      }
    }
  }
}
