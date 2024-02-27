// student.dart
class Student {
  final String name;
  final List<Grade> grades;

  Student(this.name, this.grades);
}

// grade.dart
class Grade {
  final String subject;
  final double score;

  Grade(this.subject, this.score);
}


class Task {
  final String title;
  final String description;

  Task(this.title, this.description);
}
