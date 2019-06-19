import 'package:mobx/mobx.dart';
part 'todo.g.dart';

class Todo = _Todo with _$Todo;

abstract class _Todo with Store {
  _Todo({
    this.id,
    this.title = '',
    this.content = '',
    this.isTop = false,
    DateTime createTime,
  }) : createTime = createTime ?? DateTime.now();

  int id;
  @observable
  bool isSelect = false;

  /// 标题
  @observable
  String title = '';

  /// 内容
  @observable
  String content = '';

  /// 是否置顶
  @observable
  bool isTop;

  /// 创建时间
  @observable
  DateTime createTime;

  /// 创建时间
  @computed
  String get createTimeString {
    var now = new DateTime.now();
    // 一天前
    var oneDayAgo = now.subtract(const Duration(days: 1));
    // 一年前
    var aYearAgo = now.subtract(const Duration(days: 365));
    bool isOneDayAgo = createTime.isBefore(oneDayAgo);
    bool isAYearAgo = createTime.isBefore(aYearAgo);
    if (isAYearAgo) {
      return '${createTime.year}年${createTime.month}月';
    } else if (isOneDayAgo) {
      return '${createTime.month}月${createTime.day}号';
    } else {
      return '${createTime.hour}:${createTime.minute}';
    }
  }

  /// 用于排序
  int operator -(_Todo e) {
    int a = isTop ? 1 : 0;
    int b = e.isTop ? 1 : 0;
    return a - b;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "isTop": isTop ? 1 : 0,
      "createTime": createTime.toString(),
    };
  }
}
