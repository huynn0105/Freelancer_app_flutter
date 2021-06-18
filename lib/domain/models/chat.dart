class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;
  final int id;

  Chat({
    this.id,
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    id: 18,
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/avatar.jpg",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    id: 17,
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/avatar.jpg",
    time: "8m ago",
    isActive: true,
  ),
];