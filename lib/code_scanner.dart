import 'dart:io';
import 'report_generator.dart';

void main() {
  final scanner = CodeScanner();
  final reportGenerator = ReportGenerator();

  scanner.scanProject(Directory.current.path, reportGenerator);
  reportGenerator.generateReport();
}

class CodeScanner {
  void scanProject(String path, ReportGenerator reportGenerator) {
    final directory = Directory(path);
    final dartFiles = directory.listSync(recursive: true)
      .where((file) => file.path.endsWith('.dart'));

    for (var file in dartFiles) {
      scanFile(file as File, reportGenerator);
    }
  }

  void scanFile(File file, ReportGenerator reportGenerator) {
    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.contains(RegExp(r'password\s*=\s*\".*\"'))) {
        final issue = 'Hard-coded password found in ${file.path} at line ${i + 1}';
        reportGenerator.addIssue(issue);
      }
      if (line.contains(RegExp(r'SharedPreferences|FileIO'))) {
        final issue = 'Insecure storage method found in ${file.path} at line ${i + 1}';
        reportGenerator.addIssue(issue);
      }
    }
  }
}
