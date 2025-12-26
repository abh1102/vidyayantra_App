import '../models/class_model.dart';
import '../models/student_model.dart';
import '../models/homework_model.dart';
import '../models/chat_model.dart';

class TeacherRepository {
  Future<List<ClassModel>> getAssignedClasses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      ClassModel(id: '1', name: 'Class 10', section: 'A', studentCount: 35, subject: 'Mathematics'),
      ClassModel(id: '2', name: 'Class 10', section: 'B', studentCount: 32, subject: 'Mathematics'),
      ClassModel(id: '3', name: 'Class 9', section: 'A', studentCount: 40, subject: 'Science'),
      ClassModel(id: '4', name: 'Class 8', section: null, studentCount: 28, subject: 'Physics'),
      ClassModel(id: '5', name: 'Class 11', section: 'Science', studentCount: 45, subject: 'Chemistry'),
    ];
  }

  Future<List<StudentModel>> getStudentsByClass(String classId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      StudentModel(id: 's1', name: 'Rahul Kumar', rollNumber: '01', className: 'Class 10', section: 'A', attendancePercentage: 92.5),
      StudentModel(id: 's2', name: 'Priya Sharma', rollNumber: '02', className: 'Class 10', section: 'A', attendancePercentage: 88.0),
      StudentModel(id: 's3', name: 'Amit Singh', rollNumber: '03', className: 'Class 10', section: 'A', attendancePercentage: 95.0),
      StudentModel(id: 's4', name: 'Sneha Patel', rollNumber: '04', className: 'Class 10', section: 'A', attendancePercentage: 78.5),
      StudentModel(id: 's5', name: 'Vikram Reddy', rollNumber: '05', className: 'Class 10', section: 'A', attendancePercentage: 85.0),
      StudentModel(id: 's6', name: 'Anjali Gupta', rollNumber: '06', className: 'Class 10', section: 'A', attendancePercentage: 91.0),
      StudentModel(id: 's7', name: 'Karan Mehta', rollNumber: '07', className: 'Class 10', section: 'A', attendancePercentage: 82.0),
      StudentModel(id: 's8', name: 'Neha Verma', rollNumber: '08', className: 'Class 10', section: 'A', attendancePercentage: 94.5),
    ];
  }

  Future<StudentModel> getStudentDetails(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StudentModel(
      id: studentId,
      name: 'Rahul Kumar',
      rollNumber: '01',
      className: 'Class 10',
      section: 'A',
      parentId: 'p1',
      parentName: 'Mr. Kumar',
      parentPhone: '+91 98765 43210',
      attendancePercentage: 92.5,
    );
  }

  Future<bool> assignHomework(HomeworkModel homework) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<List<HomeworkModel>> getAssignedHomework() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      HomeworkModel(
        id: 'h1',
        subject: 'Mathematics',
        description: 'Complete exercises 5.1 to 5.5 from NCERT textbook',
        teacherName: 'Mr. Sharma',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        createdAt: DateTime.now(),
        className: 'Class 10',
        section: 'A',
      ),
      HomeworkModel(
        id: 'h2',
        subject: 'Science',
        description: 'Prepare notes on Chapter 3 - Chemical Reactions',
        teacherName: 'Mr. Sharma',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        className: 'Class 9',
        section: 'A',
      ),
    ];
  }

  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      ChatModel(id: 'c1', name: 'Rahul Kumar', lastMessage: 'Thank you sir', lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)), unreadCount: 0),
      ChatModel(id: 'c2', name: 'Mr. Kumar (Parent)', lastMessage: 'When is the next PTM?', lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)), unreadCount: 1),
      ChatModel(id: 'c3', name: 'Class 10-A Group', lastMessage: 'Tomorrow is holiday', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), isGroup: true, unreadCount: 5),
      ChatModel(id: 'c4', name: 'Priya Sharma', lastMessage: 'I have a doubt in chapter 5', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), unreadCount: 2),
    ];
  }

  Future<bool> sendNotification({
    required String type,
    required String message,
    String? recipientId,
    String? classId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
