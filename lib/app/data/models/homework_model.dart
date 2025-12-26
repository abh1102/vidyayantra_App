class HomeworkModel {
  final String id;
  final String subject;
  final String description;
  final String? teacherName;
  final String? teacherId;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final String? attachment;
  final String? attachmentType;
  final HomeworkStatus status;
  final String? className;
  final String? section;

  HomeworkModel({
    required this.id,
    required this.subject,
    required this.description,
    this.teacherName,
    this.teacherId,
    this.dueDate,
    this.createdAt,
    this.attachment,
    this.attachmentType,
    this.status = HomeworkStatus.pending,
    this.className,
    this.section,
  });

  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      teacherName: json['teacher_name'],
      teacherId: json['teacher_id'],
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      attachment: json['attachment'],
      attachmentType: json['attachment_type'],
      status: HomeworkStatus.fromString(json['status'] ?? 'pending'),
      className: json['class_name'],
      section: json['section'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'description': description,
      'teacher_name': teacherName,
      'teacher_id': teacherId,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'attachment': attachment,
      'attachment_type': attachmentType,
      'status': status.value,
      'class_name': className,
      'section': section,
    };
  }
}

enum HomeworkStatus {
  pending('pending'),
  completed('completed'),
  overdue('overdue');

  final String value;
  const HomeworkStatus(this.value);

  static HomeworkStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'completed':
        return HomeworkStatus.completed;
      case 'overdue':
        return HomeworkStatus.overdue;
      default:
        return HomeworkStatus.pending;
    }
  }
}
