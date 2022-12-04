import 'package:flutter_bloc/flutter_bloc.dart';

enum BookmarkEvent {
  add,
  remove,
}

enum BookmarkType { anime }

class BookmarkModel {
  final String key;
  final BookmarkType type;
  final dynamic data;

  BookmarkModel({
    required this.key,
    required this.type,
    required this.data,
  });
}

class BookmarkBloc extends Bloc<BookmarkEvent, List<String>> {
  List<BookmarkModel> _bookmarks = [];

  BookmarkBloc() : super([]);

  @override
  Stream<List<String>> mapEventToState(BookmarkEvent event) async* {
    switch (event) {
      case BookmarkEvent.add:
        _bookmarks.add(new BookmarkModel(
          key: '1',
          type: BookmarkType.anime,
          data: {},
        ));
        break;
      case BookmarkEvent.remove:
        print('remove');
        break;
    }
  }
}
