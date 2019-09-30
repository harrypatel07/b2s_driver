import 'message.dart';

class ChatModel {
  final int userId;
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;
  final List<Message> listMessage;
  ChatModel(
      {this.userId,
      this.avatarUrl,
      this.name,
      this.datetime,
      this.message,
      this.listMessage});

  static List<ChatModel> dummyData = [
    ChatModel(
        userId: 1,
        avatarUrl:
            "https://cdn.lolwot.com/wp-content/uploads/2016/02/20-of-the-most-unbelievably-stunning-women-1.jpg",
        name: "Ms Phương",
        datetime: "20:18",
        message: "Hôm nay trường có sự kiện abc",
        listMessage: [
          Message("Hôm nay trường có sự kiện abc", false),
          Message("Sự kiện diễn ra khi nào vậy cô?", true),
        ]),
    ChatModel(
        userId: 2,
        avatarUrl: "https://cdn.pornpics.com/pics/2011-07-02/17558_05big.jpg",
        name: "Ms Châu",
        datetime: "19:22",
        message: "hmmmm....",
        listMessage: [
          Message("hmmmm....", false),
        ]),
    ChatModel(
        userId: 3,
        avatarUrl: "https://randomuser.me/api/portraits/men/81.jpg",
        name: "Mr Tho",
        datetime: "11:05",
        message: "hmmmm...",
        listMessage: [
          Message("hmmmm....", false),
        ]),
    ChatModel(
        userId: 4,
        avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
        name: "Mr Minh",
        datetime: "09:46",
        message: "hmmmm...",
        listMessage: [
          Message("hmmmm....", false),
        ])
  ];
}
