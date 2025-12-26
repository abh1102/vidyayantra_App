import '../models/homework_model.dart';
import '../models/progress_model.dart';
import '../models/chat_model.dart';
import '../models/student_model.dart';

class StudentRepository {
  Future<List<HomeworkModel>> getHomeworkList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      HomeworkModel(
        id: 'h1',
        subject: 'Mathematics',
        description: 'Complete exercises 5.1 to 5.5 from NCERT textbook. Show all working steps clearly.',
        teacherName: 'Mr. Sharma',
        dueDate: DateTime.now().add(const Duration(days: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: HomeworkStatus.pending,
      ),
      HomeworkModel(
        id: 'h2',
        subject: 'Science',
        description: 'Prepare notes on Chapter 3 - Chemical Reactions and Equations',
        teacherName: 'Mrs. Gupta',
        dueDate: DateTime.now().add(const Duration(days: 4)),
        createdAt: DateTime.now(),
        status: HomeworkStatus.pending,
      ),
      HomeworkModel(
        id: 'h3',
        subject: 'English',
        description: 'Write an essay on "My Role Model" in 500 words',
        teacherName: 'Ms. Patel',
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        status: HomeworkStatus.completed,
      ),
      HomeworkModel(
        id: 'h4',
        subject: 'Hindi',
        description: 'Learn poem "वह तोड़ती पत्थर" and write its summary',
        teacherName: 'Mr. Verma',
        dueDate: DateTime.now().subtract(const Duration(days: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        status: HomeworkStatus.overdue,
      ),
    ];
  }

  Future<HomeworkModel> getHomeworkDetails(String homeworkId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return HomeworkModel(
      id: homeworkId,
      subject: 'Mathematics',
      description: 'Complete exercises 5.1 to 5.5 from NCERT textbook. Show all working steps clearly.\n\nTopics covered:\n- Linear equations\n- Quadratic equations\n- Word problems\n\nSubmit in a neat and clean notebook.',
      teacherName: 'Mr. Sharma',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: HomeworkStatus.pending,
      attachment: 'sample_worksheet.pdf',
      attachmentType: 'pdf',
    );
  }

  Future<bool> markHomeworkComplete(String homeworkId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<ProgressModel> getProgress() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return ProgressModel(
      studentId: 's1',
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

  Future<StudentModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return StudentModel(
      id: 's1',
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

  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      ChatModel(id: 'c1', name: 'Mr. Sharma (Math)', lastMessage: 'Keep up the good work!', lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)), unreadCount: 0),
      ChatModel(id: 'c2', name: 'Mrs. Gupta (Science)', lastMessage: 'Check your lab report', lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)), unreadCount: 1),
      ChatModel(id: 'c3', name: 'Class 10-A Group', lastMessage: 'Tomorrow is holiday', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)), isGroup: true, unreadCount: 12),
    ];
  }
}
