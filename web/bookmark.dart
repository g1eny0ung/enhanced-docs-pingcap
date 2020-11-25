import 'dart:html';
import 'package:js/js.dart';
import 'package:node_interop/util.dart' show dartify;
import 'package:over_react/over_react.dart';
import 'chrome.dart' as chrome;
import 'utils.dart' show parseFavorites;

part 'bookmark.over_react.g.dart';

mixin BookmarkProps on UiProps {}

UiFactory<BookmarkProps> Bookmark = uiFunction((props) {
  final marked = useState(false);

  void handleMark(_) {
    final isMarked = marked.value;

    marked.set(!isMarked);

    chrome.storageSyncGet(
      chrome.StorageObjectLiteral(favorites: {}),
      allowInterop((items) {
        final f = dartify(items.favorites);
        parseFavorites(f);

        final href = window.location.href;

        if (isMarked) {
          f.remove(href);
        } else {
          final title = document.title;

          f[href] = title;
        }

        chrome.storageSyncSet(chrome.StorageObjectLiteral(favorites: f));
      }),
    );
  }

  return (Dom.div()..className = 'edp-box')(
    (Dom.span()
      ..className =
          '${marked.value ? 'icon-bookmark marked' : 'icon-bookmark-o'} bookmark'
      ..onClick = handleMark)(),
  );
}, $BookmarkConfig);
