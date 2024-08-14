import 'dart:io';

class ReportGenerator {
  final List<String> issues = [];

  void addIssue(String issue) {
    issues.add(issue);
  }

  void generateReport() {
    final reportFile = File('security_assessment_report.md');
    final buffer = StringBuffer();

    buffer.writeln('# Security Assessment Report');
    buffer.writeln();
    buffer.writeln('## Security Issues Found:');
    buffer.writeln();

    if (issues.isEmpty) {
      buffer.writeln('No major security issues detected.');
    } else {
      for (var issue in issues) {
        buffer.writeln('- $issue');
      }
    }

    reportFile.writeAsStringSync(buffer.toString());
    print('Security assessment report generated: ${reportFile.path}');
  }
}
