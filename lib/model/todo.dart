class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Olahraga Pagi', isDone: true),
      ToDo(id: '02', todoText: 'Beli Belanjaan Mingguan', isDone: true),
      ToDo(id: '03', todoText: 'Cek & Balas Email Masuk'),
      ToDo(id: '04', todoText: 'Meeting Tim Proyek'),
      ToDo(id: '05', todoText: 'Kembangkan Aplikasi Flutter'),
      ToDo(id: '06', todoText: 'Makan Malam Bersama Keluarga'),
    ];
  }
}
