class ProgressModel {
  final String studentId;
  final String studentName;
  final double attendancePercentage;
  final List<SubjectProgress> subjectProgress;
  final int totalHomework;
  final int completedHomework;

  ProgressModel({
    required this.studentId,
    required this.studentName,
    required this.attendancePercentage,
    required this.subjectProgress,
    required this.totalHomework,
    required this.completedHomework,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      studentId: json['student_id'] ?? '',
      studentName: json['student_name'] ?? '',
      attendancePercentage: (json['attendance_percentage'] ?? 0).toDouble(),
      subjectProgress: (json['subject_progress'] as List? ?? [])
          .map((e) => SubjectProgress.fromJson(e))
          .toList(),
      totalHomework: json['total_homework'] ?? 0,
      completedHomework: json['completed_homework'] ?? 0,
    );
  }

  double get homeworkCompletionRate =>
      totalHomework > 0 ? (completedHomework / totalHomework) * 100 : 0;
}

class SubjectProgress {
  final String subject;
  final double marks;
  final double totalMarks;
  final String? grade;

  SubjectProgress({
    required this.subject,
    required this.marks,
    required this.totalMarks,
    this.grade,
  });

  factory SubjectProgress.fromJson(Map<String, dynamic> json) {
    return SubjectProgress(
      subject: json['subject'] ?? '',
      marks: (json['marks'] ?? 0).toDouble(),
      totalMarks: (json['total_marks'] ?? 100).toDouble(),
      grade: json['grade'],
    );
  }

  double get percentage => totalMarks > 0 ? (marks / totalMarks) * 100 : 0;
}
