import 'package:over_react/over_react.dart';

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  final marked = useState(false);

  void handleMark(_) {
    marked.set(!marked.value);
  }

  return (Dom.div()..className = 'edp-box')(
    (Dom.span()
      ..className =
          '${marked.value ? 'icon-bookmark marked' : 'icon-bookmark-o'} bookmark'
      ..onClick = handleMark)(),
  );
}, $BookmarkConfig);
