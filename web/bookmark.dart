import 'package:over_react/over_react.dart';

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  return Dom.div()();
}, $BookmarkConfig);
