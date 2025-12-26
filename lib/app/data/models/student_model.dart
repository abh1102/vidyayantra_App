class StudentModel {
  final String id;
  final String name;
  final String? rollNumber;
  final String? profilePhoto;
  final String? className;
  final String? section;
  final String? parentId;
  final String? parentName;
  final String? parentPhone;
  final double? attendancePercentage;

  StudentModel({
    required this.id,
    required this.name,
    this.rollNumber,
    this.profilePhoto,
    this.className,
    this.section,
    this.parentId,
    this.parentName,
    this.parentPhone,
    this.attendancePercentage,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rollNumber: json['roll_number'],
      profilePhoto: json['profile_photo'],
      className: json['class_name'],
      section: json['section'],
      parentId: json['parent_id'],
      parentName: json['parent_name'],
      parentPhone: json['parent_phone'],
      attendancePercentage: json['attendance_percentage']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'roll_number': rollNumber,
      'profile_photo': profilePhoto,
      'class_name': className,
      'section': section,
      'parent_id': parentId,
      'parent_name': parentName,
      'parent_phone': parentPhone,
      'attendance_percentage': attendancePercentage,
    };
  }
}
