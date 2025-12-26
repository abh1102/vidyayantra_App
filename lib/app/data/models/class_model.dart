class ClassModel {
  final String id;
  final String name;
  final String? section;
  final int studentCount;
  final String? subject;

  ClassModel({
    required this.id,
    required this.name,
    this.section,
    this.studentCount = 0,
    this.subject,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      section: json['section'],
      studentCount: json['student_count'] ?? 0,
      subject: json['subject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'section': section,
      'student_count': studentCount,
      'subject': subject,
    };
  }

  String get displayName => section != null ? '$name - $section' : name;
}
