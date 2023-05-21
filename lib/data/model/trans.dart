class Transaction {
  String uid;
  String title;
  DateTime date;
  String category;
  String type;
  String? note;
  String? image;

  Transaction({
    required this.uid,
    required this.title,
    required this.date,
    required this.category,
    required this.type,
    this.note,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
      'note': note,
      'image': image,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      uid: map['uid'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      category: map['category'],
      type: map['type'],
      note: map['note'],
      image: map['image'],
    );
  }

  @override
  String toString() {
    return 'Transaction(uid: $uid, title: $title, date: $date, category: $category, type: $type,note: $note, image: $image)';
  }
}
