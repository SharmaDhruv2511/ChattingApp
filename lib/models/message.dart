class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late final String toId;
  late final String msg;
  late final String read;
  late final Type type;
  late final String fromId;
  late final String sent;

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toId'] = toId;
    _data['msg'] = msg;
    _data['read'] = read;
    _data['type'] = type.name;
    _data['fromId'] = fromId;
    _data['sent'] = sent;
    return _data;
  }
}

enum Type { text, image }
