// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;

// class DatabaseHelper {
//   static late Box<Map<String, dynamic>> _messagesBox;

//   static Future<void> initialize() async {
//     final appDocumentDir =
//         await path_provider.getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDir.path);
//     Hive.registerAdapter<ChatMessage>(ChatMessageAdapter());
//     _messagesBox = await Hive.openBox<Map<String, dynamic>>('messages');
//   }

//   Future<List<Map<String, dynamic>>> getMessages() async {
//     return _messagesBox.values.toList();
//   }

//   Future<void> insertMessage(Map<String, dynamic> message) async {
//     await _messagesBox.add(message);
//   }
// }

// @HiveType(typeId: 0)
// class ChatMessage {
//   @HiveField(0)
//   late String text;

//   @HiveField(1)
//   late DateTime timestamp;

//   ChatMessage({required this.text, required this.timestamp});
// }

// class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
//   @override
//   final int typeId = 0;

//   @override
//   ChatMessage read(BinaryReader reader) {
//     return ChatMessage(
//       text: reader.readString(),
//       timestamp: DateTime.parse(reader.readString() ?? ""),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, ChatMessage obj) {
//     writer.writeString(obj.text);
//     writer.writeString(obj.timestamp.toIso8601String());
//   }
// }
