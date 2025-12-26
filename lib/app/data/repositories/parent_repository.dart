import '../models/progress_model.dart';
import '../models/chat_model.dart';
import '../models/student_model.dart';

class ParentRepository {
  Future<List<StudentModel>> getChildren() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      StudentModel(
        id: 's1',
        name: 'Rahul Kumar',
        rollNumber: '01',
        className: 'Class 10',
        section: 'A',
        attendancePercentage: 92.5,
      ),
    ];
  }

  Future<ProgressModel> getChildProgress(String childId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return ProgressModel(
      studentId: childId,
      studentName: 'Rahul Kumar',
      attendancePercentage: 92.5,
      subjectProgress: [
        SubjectProgress(subject: 'Mathematics', marks: 85, totalMarks: 100, grade: 'A'),
        SubjectProgress(subject: 'Science', marks: 78, totalMarks: 100, grade: 'B+'),
        SubjectProgress(subject: 'English', marks: 92, totalMarks: 100, grade: 'A+'),
        SubjectProgress(subject: 'Hindi', marks: 88, totalMarks: 100, grade: 'A'),
        SubjectProgress(subject: 'Social Studies', marks: 75, totalMarks: 100, grade: 'B'),
      ],
      totalHomework: 25,
      completedHomework: 22,
    );
  }

  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      ChatModel(id: 'c1', name: 'Mr. Sharma (Math Teacher)', lastMessage: 'Rahul is doing well', lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)), unreadCount: 0),
      ChatModel(id: 'c2', name: 'Mrs. Gupta (Class Teacher)', lastMessage: 'PTM on Saturday', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), unreadCount: 1),
      ChatModel(id: 'c3', name: 'School Admin', lastMessage: 'Fee reminder for December', lastMessageTime: DateTime.now().subtract(const Duration(days: 2)), unreadCount: 0),
    ];
  }

  Future<Map<String, dynamic>> getParentProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return {
      'id': 'p1',
      'name': 'Mr. Kumar',
      'email': 'parent@demo.com',
      'phone': '+91 98765 43210',
      'children': ['Rahul Kumar'],
    };
  }
}
