import 'dart:convert';
import 'package:aniline/models/bookmark.dart';
import 'package:eventify/eventify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  static EventEmitter emitter = EventEmitter();
  static final List<BookmarkItemModel> _bookmarks_items = [];

  static List<BookmarkItemModel> getBookmarks() {
    return _bookmarks_items;
  }

  static addBookmark({required String id, required String type}) {
    // check if already exist, return
    final item = _bookmarks_items.firstWhere(
      (element) => element.id == id,
      orElse: () =>
          BookmarkItemModel(id: '', addedAt: DateTime.now(), type: ''),
    );
    if (item.id.isNotEmpty) return;

    _bookmarks_items.add(BookmarkItemModel(
      id: id.toString(),
      addedAt: DateTime.now(),
      type: type,
    ));
    emitter.emit('add');
    _onUpdate();
  }

  static removeBookmark({required String id}) {
    _bookmarks_items.removeWhere((element) => element.id == id);
    emitter.emit('remove');
    _onUpdate();
  }

  static _onUpdate() {
    emitter.emit('updated');
    dbSave();
  }

  static Future<bool> dbSave() async {
    print('DB: Saving to DB');
    final prefs = await SharedPreferences.getInstance();
    final bookmarks_items =
        jsonEncode(_bookmarks_items.map((e) => e.toJson()).toList());
    prefs.setString('bookmarks', bookmarks_items);
    print('DB: Saved to DB');
    print(bookmarks_items);

    return true;
  }

  static Future<bool> dbRead() async {
    await Future.delayed(Duration(milliseconds: 1000));
    print('DB: Reading from DB');
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getString('bookmarks');
    if (items == null) return true;
    final itemsJson = jsonDecode(items);
    if (itemsJson is List) {
      _bookmarks_items.clear();
      for (var item in itemsJson) {
        print('${item['id']} - ${item['type']} - ${item['addedAt']}');
        _bookmarks_items.add(BookmarkItemModel.fromJson(item));
      }
    }
    return true;
  }
}
