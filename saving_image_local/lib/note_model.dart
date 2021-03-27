class NoteModel {
  NoteModel({
    this.id,
    this.image,
    this.note,
  });

  int id;
  String note;
  String image;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        note: json['note'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'note': note,
        'image': image,
      };
}
